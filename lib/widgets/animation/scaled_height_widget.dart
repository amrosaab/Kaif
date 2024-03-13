import 'package:flutter/material.dart';

class ScaledHeightWidget extends StatefulWidget {
  const ScaledHeightWidget({
    super.key,
    required this.child,
    this.scaleOrigin,
    this.duration = const Duration(milliseconds: 750),
    this.delay = Duration.zero,
  });

  final Widget child;
  final Alignment? scaleOrigin;
  final Duration duration;
  final Duration delay;

  @override
  State<ScaledHeightWidget> createState() => _ScaledHeightWidgetState();
}

class _ScaledHeightWidgetState extends State<ScaledHeightWidget> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );


  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();

    //delay the animation
    Future.delayed(widget.delay, () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: widget.child,
    );
  }
}
