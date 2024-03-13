import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app.dart';
import '../../../../common/config.dart';
import '../../../../common/constants.dart';
import '../../../../common/events.dart';
import '../../../../common/tools/flash.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/index.dart';
import '../../../../modules/sms_login/sms_login.dart';
import '../../../../services/index.dart';
import '../../../../widgets/common/webview.dart';
import '../../../base_screen.dart';
import '../../forgot_password_screen.dart';

typedef LoginSocialFunction = Future<void> Function({
  required Function(User user) success,
  required Function(String) fail,
  BuildContext context,
});

typedef LoginFunction = Future<void> Function({
  required String username,
  required String password,
  required Function(User user) success,
  required Function(String) fail,
});

mixin LoginMixin<T extends StatefulWidget> on BaseScreen<T> {
  bool _isActiveAudio = false;

  Future<void> beforeCallLogin();
  Future<void> afterCallLogin(bool isLoginSuccess);

  TextEditingController get usernameCtrl;
  TextEditingController get passwordCtrl;
  VoidCallback? get loginSms => null;
  bool get isActiveAudio => _isActiveAudio;

  UserModel get _userModel => Provider.of<UserModel>(context, listen: false);
  LoginFunction get _login => _userModel.login;
  LoginSocialFunction get _loginFB => _userModel.loginFB;
  LoginSocialFunction get _loginApple => _userModel.loginApple;
  LoginSocialFunction get _loginGoogle => _userModel.loginGoogle;
  AudioManager get _audioPlayerService => injector<AudioManager>();

  void redirectingAfterLoginSuccess() {
    final canPop = ModalRoute.of(context)!.canPop;
    if (canPop) {
      // When not required login
      Navigator.of(context).pop();
    } else {
      // When required login
      Navigator.of(App.fluxStoreNavigatorKey.currentContext!)
          .pushReplacementNamed(RouteList.dashboard);
    }
  }

  void loginDone() {
    _updateEventBus();
    redirectingAfterLoginSuccess();
  }

  void loginWithFacebook(context) async {
    //showLoading();
    await beforeCallLogin();
    await _loginFB(
      success: (user) {
        //hideLoading();
        afterCallLogin(true);
        loginDone();
      },
      fail: (message) {
        //hideLoading();
        afterCallLogin(false);
        _failMessage(message);
      },
      context: context,
    );
  }

  void loginWithApple(context) async {
    await beforeCallLogin();
    await _loginApple(
        success: (user) {
          afterCallLogin(true);
          loginDone();
        },
        fail: (message) {
          afterCallLogin(false);
          _failMessage(message);
        },
        context: context);
  }

  Future<void> runLogin(context) async {
    if (usernameCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
      unawaited(
        FlashHelper.errorMessage(context,
            message: S.of(context).pleaseInputFillAllFields),
      );
    } else {
      await beforeCallLogin();
      await _login(
        username: usernameCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
        success: (user) {
          afterCallLogin(true);
          loginDone();
        },
        fail: (message) {
          afterCallLogin(false);
          _failMessage(message);
        },
      );
    }
  }

  void launchForgetPasswordURL(String? url) async {
    if (url != null && url != '') {
      /// show as webview
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              WebView(url: url, title: S.of(context).resetPassword),
          fullscreenDialog: true,
        ),
      );
    } else {
      /// show as native
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
      );
    }
  }

  void loginWithSMS(context) {
    if (loginSms != null) {
      loginSms!();
      return;
    }

    final supportedPlatforms = [
      'wcfm',
      'dokan',
      'delivery',
      'vendorAdmin',
      'woo',
      'wordpress'
    ].contains(ServerConfig().typeName);

    if (kAdvanceConfig.enableDigitsMobileLogin) {
      Navigator.of(context).pushNamed(RouteList.digitsMobileLogin);
    } else if (supportedPlatforms && (kAdvanceConfig.enableNewSMSLogin)) {
      final model = Provider.of<UserModel>(context, listen: false);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SMSLoginScreen(
            onSuccess: (user) async {
              await model.setUser(user);
              Navigator.of(context).pop();
              loginDone();
            },
          ),
        ),
      );
    } else {
      Navigator.of(context).pushNamed(RouteList.loginSMS);
    }
  }

  void loginWithGoogle(context) async {
    await beforeCallLogin();
    await _loginGoogle(
        success: (user) {
          //hideLoading();
          afterCallLogin(true);
          loginDone();
        },
        fail: (message) {
          //hideLoading();
          afterCallLogin(false);
          _failMessage(message);
        },
        context: context);
  }

  void hideLoading() => Navigator.of(context).pop();

  void showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: Container(
          padding: const EdgeInsets.all(50.0),
          child: kLoadingWidget(context),
        ));
      },
    );
  }

  void _updateEventBus() {
    eventBus.fire(const EventLoggedIn());
  }

  void _failMessage(String message) {
    if (message.isEmpty) return;

    var messageText = message;
    // if (kReleaseMode) {
    //   messageText = S.of(context).UserNameInCorrect;
    // }

    FlashHelper.errorMessage(
      context,
      message: S.of(context).warning(messageText),
    );
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    if (_audioPlayerService.isStickyAudioWidgetActive) {
      _isActiveAudio = true;
      _audioPlayerService
        ..pause()
        ..hideStickyAudioWidget();
    }
  }

  @override
  void dispose() async {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
