import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/video.dart';
import 'video_buttons.dart';
import 'video_info.dart';

class VideoPlayerItem extends StatefulWidget {
  const VideoPlayerItem(
      {Key? key,
      required this.video,
      required this.playButtonVisible,
      required this.onTap})
      : super(key: key);
  final Video video;
  final bool playButtonVisible;
  final VoidCallback onTap;

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            color: Colors.black,
            child: widget.video.videoPlayerController != null
                ? Center(
                    child: AspectRatio(
                      aspectRatio:
                          widget.video.videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(widget.video.videoPlayerController!),
                    ),
                  )
                : const SizedBox(),
          ),
          if (widget.playButtonVisible)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.black.withOpacity(0.1),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  child: Icon(
                    CupertinoIcons.play_arrow_solid,
                    size: 50,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VideoButtons(
                      video: widget.video,
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: VideoInfo(product: widget.video.product),
                ),
              ],
            ),
          ),
          // video progress doesn't work smoothly
          // Positioned(
          //   left: 0,
          //   bottom: 0,
          //   right: 0,
          //   child: VideoProgressIndicator(
          //     widget.video.videoPlayerController!,
          //     allowScrubbing: true,
          //     colors: VideoProgressColors(
          //       playedColor: Theme.of(context).primaryColor,
          //       backgroundColor: Colors.black,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
