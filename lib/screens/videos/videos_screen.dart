import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:inspireui/widgets/platform_error/platform_error.dart';
import 'package:provider/provider.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../common/constants.dart';
import '../../generated/l10n.dart';
import '../../models/app_model.dart';
import '../../models/entities/product.dart';
import '../common/app_bar_mixin.dart';
import 'models/video.dart';
import 'services/videos_services.dart';
import 'widgets/video_player_item.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> with AppBarMixin {
  late Controller controller;

  final VideoServices _videoServices = VideoServices();
  String get langCode => Provider.of<AppModel>(context, listen: false).langCode;

  bool _isIniting = true;
  String? _errMsg;
  List<Video> _videos = [];
  int _currentIndex = 0;

  bool _playButtonVisible = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _refreshItems().then((value) => setState(() {
              _isIniting = false;
            }));
      }
    });
    controller = Controller()
      ..addListener((event) {
        _handleCallbackEvent(event.direction, event.success,
            currentIndex: event.pageNo);
      });
    super.initState();
  }

  String _getVimeoVideoId(String url) {
    var vimeoVideoId = '';
    var videoIdGroup = 4;
    for (var exp in [
      RegExp(r'^((https?):\/\/)?(www.)?vimeo\.com\/([0-9]+).*$'),
    ]) {
      var match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        vimeoVideoId = match.group(videoIdGroup) ?? '';
      }
    }
    return vimeoVideoId;
  }

  Future _refreshItems() async {
    try {
      setState(() {
        _errMsg = null;
      });
      var products = await _videoServices.refreshItems(langCode);
      var items = await _initVideos(products);
      setState(() {
        _isIniting = false;
        _videos = items;
      });
    } catch (err) {
      setState(() {
        _errMsg = err.toString();
      });
    }
  }

  Future _loadMoreItems() async {
    try {
      if (!_videoServices.hasNextPage) return;
      var products = await _videoServices.loadMoreItems(langCode);
      var items = await _initVideos(products);
      setState(() {
        _videos = [..._videos, ...items];
      });
    } catch (err) {
      setState(() {
        _errMsg = err.toString();
      });
    }
  }

  Future<List<Video>> _initVideos(List<Product> products) async {
    var items = <Video>[];
    try {
      for (var product in products) {
        var videoId = _getVimeoVideoId(product.mVideoUrl ?? '');
        var videoUrl = videoId.isEmpty ? product.mVideoUrl ?? '' : '';
        if (videoId.isNotEmpty) {
          var videoConfig =
              await _videoServices.getVimeoVideoConfig(vimeoVideoId: videoId);
          videoUrl = videoConfig?.request?.files?.progressive
                  ?.firstWhereOrNull(
                      (e) => e?.quality == '360p' || e?.quality == '720p')
                  ?.url ??
              product.mVideoUrl ??
              '';
        }
        var videoPlayerController = VideoPlayerController.network(
          videoUrl,
          videoPlayerOptions:
              VideoPlayerOptions(allowBackgroundPlayback: false),
        );
        videoPlayerController.addListener(() {
          var duration = videoPlayerController.value.duration;
          var position = videoPlayerController.value.position;
          if (duration.compareTo(position) == 0 ||
              duration.compareTo(position) == -1) {
            if (_currentIndex < _videos.length - 1) {
              controller.animateToPosition(_currentIndex + 1);
            } else {
              _playButtonVisible = true;
            }
          }
        });
        await videoPlayerController.initialize();
        items.add(Video(
            product: product,
            videoUrl: videoUrl,
            videoPlayerController: videoPlayerController));
      }
    } catch (_) {}
    return items;
  }

  @override
  Widget build(BuildContext context) {
    // video_player only supports Android and iOS
    if (kIsWeb || isDesktop) {
      return const PlatformError();
    }
    return renderScaffold(
        routeName: RouteList.videos,
        child: _isIniting
            ? const Center(child: CircularProgressIndicator())
            : _videos.isEmpty
                ? Center(
                    child: Text(
                        (_errMsg?.isNotEmpty ?? false)
                            ? _errMsg!
                            : S.of(context).dataEmpty,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.white)))
                : RefreshIndicator(
                    color: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    strokeWidth: 4.0,
                    onRefresh: () async {
                      await _refreshItems();
                    },
                    child: VisibilityDetector(
                      key: const Key('visible-video'),
                      onVisibilityChanged: _onVisibilityChangedScreen,
                      child: TikTokStyleFullPageScroller(
                        contentSize: _videos.length,
                        swipePositionThreshold: 0.5,
                        swipeVelocityThreshold: 1000,
                        animationDuration: const Duration(milliseconds: 200),
                        controller: controller,
                        builder: (BuildContext context, int index) {
                          return VideoPlayerItem(
                              video: _videos[index],
                              playButtonVisible: _playButtonVisible,
                              onTap: _onTapScreen);
                        },
                      ),
                    ),
                  ));
  }

  Future _handleCallbackEvent(ScrollDirection direction, ScrollSuccess success,
      {int? currentIndex}) async {
    if (success == ScrollSuccess.SUCCESS && currentIndex != null) {
      var prevController = _videos[_currentIndex].videoPlayerController;
      if (prevController?.value.isPlaying ?? false) {
        await prevController?.pause();
        await prevController?.seekTo(Duration.zero);
      }
      var controller = _videos[currentIndex].videoPlayerController;
      await controller?.seekTo(Duration.zero);
      if (!(controller?.value.isPlaying ?? true)) {
        await controller?.play();
      }
      setState(() {
        _playButtonVisible = false;
        _currentIndex = currentIndex;
      });
    }
    if (currentIndex != null && currentIndex >= _videos.length - 2) {
      unawaited(_loadMoreItems());
    }
  }

  Future _onTapScreen() async {
    if (!(_videos[_currentIndex].videoPlayerController?.value.isPlaying ??
        true)) {
      await _videos[_currentIndex].videoPlayerController?.play();
    } else {
      await _videos[_currentIndex].videoPlayerController?.pause();
    }
    setState(() {
      _playButtonVisible =
          !(_videos[_currentIndex].videoPlayerController?.value.isPlaying ??
              true);
    });

    // if (!(_videos[_currentIndex].vimeoPlayerController?.value.isPlaying ??
    //     true)) {
    //   _videos[_currentIndex].vimeoPlayerController?.play();
    // } else {
    //   _videos[_currentIndex].vimeoPlayerController?.pause();
    // }
    // setState(() {
    //   _playButtonVisible =
    //       !(_videos[_currentIndex].vimeoPlayerController?.value.isPlaying ??
    //           true);
    // });
  }

  Future _onVisibilityChangedScreen(VisibilityInfo info) async {
    var videoPlayerController = _videos[_currentIndex].videoPlayerController;
    var visiblePercentage = info.visibleFraction * 100;
    if (visiblePercentage < 1) {
      await videoPlayerController?.pause();
    } else {
      !_playButtonVisible
          ? await videoPlayerController?.play()
          : await videoPlayerController?.pause();
    }
  }
}
