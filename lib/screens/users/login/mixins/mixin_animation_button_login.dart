import 'package:flutter/material.dart';

import '../../../../common/constants.dart';

/// [AnimationButtonLoginMixin] is a mixin that supports using animation for
/// buttons on the login screen.
///
/// To use [AnimationButtonLoginMixin], the screen needs to use
/// [AnimationButtonLoginMixin] and [TickerProviderStateMixin] at the same time.
///
/// {@tool snippet}
/// Example:
///
/// ```dart
/// class LoginExampleScreen extends StatefulWidget {
///   const LoginExampleScreen({super.key});
///   @override
///   State<LoginExampleScreen> createState() => _LoginExampleScreenState();
/// }
///
/// class _LoginExampleScreenState extends State<LoginExampleScreen>
///     with TickerProviderStateMixin, AnimationButtonLoginMixin {
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Column(children: [
///         StaggerAnimation(
///           titleButton: 'Login',
///           buttonController: loginButtonController.view as AnimationController,
///           onTap: () {},
///         ),
///       ]),
///     );
///   }
/// }
/// ```
/// {@end-tool}
mixin AnimationButtonLoginMixin<T extends StatefulWidget>
    on State<T>, TickerProviderStateMixin<T> {
  late AnimationController _loginButtonController;
  AnimationController get loginButtonController => _loginButtonController;

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  Future playAnimation() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      printLog('[_playAnimation] error');
    }
  }

  Future stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        _isLoading = false;
      });
    } on TickerCanceled {
      printLog('[_stopAnimation] error');
    }
  }

  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() async {
    _loginButtonController.dispose();
    super.dispose();
  }
}
