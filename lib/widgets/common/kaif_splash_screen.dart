import 'package:flutter/material.dart';

/// Kaif brand splash, ported from the designer's animation.html.
///
/// Timeline (ms): logo fades/scales in under a white curtain, the curtain
/// wipes away left to right, an accent line grows, then the tagline rises in.
class KaifSplashScreen extends StatefulWidget {
  final Function onSuccess;
  final int duration;

  const KaifSplashScreen({
    super.key,
    required this.onSuccess,
    this.duration = 5000,
  });

  @override
  State<KaifSplashScreen> createState() => _KaifSplashScreenState();
}

class _KaifSplashScreenState extends State<KaifSplashScreen>
    with SingleTickerProviderStateMixin {
  // Total length of the animation in animation.html.
  static const _animationMs = 4600;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: _animationMs),
  );

  late final Animation<double> _logo = _segment(350, 1100, Curves.easeOutCubic);
  late final Animation<double> _curtain =
      _segment(1250, 2750, Curves.easeInOutCubic);
  late final Animation<double> _line = _segment(2950, 3550, Curves.easeOutCubic);
  late final Animation<double> _tagline =
      _segment(3650, 4600, Curves.easeOutCubic);

  Animation<double> _segment(int startMs, int endMs, Curve curve) {
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(
        startMs / _animationMs,
        endMs / _animationMs,
        curve: curve,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.forward();
    final total = widget.duration < _animationMs ? _animationMs : widget.duration;
    Future.delayed(Duration(milliseconds: total), () {
      if (mounted) widget.onSuccess();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.85,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => _buildScene(),
            ),
          ),
        ),
      ),
    );
  }

  /// Same layout as the HTML at its native size; FittedBox scales it.
  Widget _buildScene() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 440,
          height: 230,
          child: ClipRect(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: _logo.value,
                  child: Transform.scale(
                    scale: 0.9 + 0.1 * _logo.value,
                    child: Image.asset(
                      'assets/images/splash_logo.png',
                      width: 400,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // White curtain anchored right, shrinking to reveal the logo.
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  width: 440 * (1 - _curtain.value),
                  child: const ColoredBox(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        Container(
          width: 260 * _line.value,
          height: 1.5,
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 16),
        Opacity(
          opacity: _tagline.value,
          child: Transform.translate(
            offset: Offset(0, 14 - 14 * _tagline.value),
            child: const Text(
              'كيف .. لأهل الكيف',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: 'SomarBlack',
                fontSize: 22,
                color: Color(0xFFFFAF00),
                letterSpacing: 0.44,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
