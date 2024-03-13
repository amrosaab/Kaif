import 'dart:async';

import 'package:flutter/material.dart';

import '../../screens/base_screen.dart';

const _kNumberDelay = 5;

class HandleAutoSlide extends StatelessWidget {
  const HandleAutoSlide.page({
    super.key,
    required this.numberOfItems,
    required PageController controller,
    required this.child,
    required this.enable,
    required this.durationAutoSliding,
  })  : _pageController = controller,
        _scrollController = null;

  const HandleAutoSlide.list({
    super.key,
    required this.numberOfItems,
    required this.child,
    required this.enable,
    required this.durationAutoSliding,
    required ScrollController controller,
  })  : _pageController = null,
        _scrollController = controller;

  final ScrollController? _scrollController;
  final PageController? _pageController;
  final bool enable;
  final int numberOfItems;
  final int? durationAutoSliding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (enable) {
      return _scrollController != null
          ? HandleAutoSlideForList(
              numberOfItems: numberOfItems,
              controller: _scrollController!,
              durationAutoSliding: durationAutoSliding,
              child: child,
            )
          : HandleAutoSlideForPage(
              numberOfItems: numberOfItems,
              controller: _pageController!,
              durationAutoSliding: durationAutoSliding,
              child: child,
            );
    }

    return child;
  }
}

class HandleAutoSlideForPage extends StatefulWidget {
  const HandleAutoSlideForPage({
    super.key,
    required this.numberOfItems,
    required this.controller,
    required this.child,
    required this.durationAutoSliding,
  });

  final PageController controller;
  final int numberOfItems;
  final int? durationAutoSliding;
  final Widget child;

  @override
  State<HandleAutoSlideForPage> createState() => _HandleAutoSlideForPageState();
}

class _HandleAutoSlideForPageState extends BaseScreen<HandleAutoSlideForPage> {
  int _position = 0;
  Timer? _timer;

  PageController? get _controller => widget.controller;
  int get _numberOfItems => widget.numberOfItems;

  void _cancelGesture() {
    if (_controller != null) {
      if (_timer != null) {
        _timer!.cancel();
      }
      _autoSlidingPage();
    }
  }

  Future<void> _autoSlidingPage() async {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (callback) {
        if (_position >= _numberOfItems - 1) {
          _controller!.animateToPage(
            0,
            duration: const Duration(seconds: 3),
            curve: Curves.linear,
          );
          _position = 0;
        } else {
          _controller!.animateToPage(
            _position + 1,
            duration: const Duration(seconds: 1),
            curve: Curves.linear,
          );
          _position = _position + 1;
        }
      },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (_controller != null) {
      _autoSlidingPage();
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragCancel: () {
        _cancelGesture();
      },
      behavior: HitTestBehavior.translucent,
      child: widget.child,
    );
  }
}

class HandleAutoSlideForList extends StatefulWidget {
  const HandleAutoSlideForList({
    super.key,
    required this.numberOfItems,
    required this.controller,
    required this.child,
    required this.durationAutoSliding,
  });

  final ScrollController controller;
  final int numberOfItems;
  final int? durationAutoSliding;
  final Widget child;

  @override
  State<HandleAutoSlideForList> createState() => _HandleAutoSlideForListState();
}

class _HandleAutoSlideForListState extends BaseScreen<HandleAutoSlideForList> {
  bool _enableAuto = true;

  ScrollController get _controller => widget.controller;
  int get _numberOfItems => widget.numberOfItems;
  int get _timeDurationDefault => _numberOfItems * _kNumberDelay;
  double? get _maxPosition => _controller.position.maxScrollExtent;
  int get _duration =>
      widget.durationAutoSliding != null && widget.durationAutoSliding! > 0
          ? widget.durationAutoSliding!
          : _timeDurationDefault;

  void _cancelGesture() {
    _enableAuto = false;

    Future.delayed(const Duration(seconds: 3)).then((value) {
      var time;

      // Multiply each pixel's running time by the number of remaining pixels
      final remainingScrollAmount = _maxPosition! - _controller.position.pixels;
      time = ((_duration / _maxPosition!) * remainingScrollAmount) ~/ 1;
      _autoSlidingScroll(time);
    });
  }

  void _onListenerController() {
    if (_enableAuto && _controller.position.pixels == _maxPosition!) {
      Future.delayed(const Duration(seconds: 1)).then((value) async {
        await _controller.animateTo(
          0,
          duration: const Duration(seconds: 2),
          curve: Curves.linear,
        );

        unawaited(_autoSlidingScroll(_duration));
      });
    }
  }

  Future<void> _autoSlidingScroll(int time) async {
    await Future.delayed(const Duration(seconds: 3));

    if (_maxPosition! != _controller.position.pixels) {
      _enableAuto = true;
      await _controller.animateTo(
        _maxPosition!,
        duration: Duration(seconds: time),
        curve: Curves.linear,
      );
    } else {
      await _controller.animateTo(
        0,
        duration: const Duration(seconds: 3),
        curve: Curves.linear,
      );
      unawaited(_autoSlidingScroll(_duration));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _controller.addListener(_onListenerController);
    _autoSlidingScroll(_duration);
  }

  @override
  void dispose() {
    _controller.removeListener(_onListenerController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragCancel: () {
        _cancelGesture();
      },
      behavior: HitTestBehavior.translucent,
      child: widget.child,
    );
  }
}
