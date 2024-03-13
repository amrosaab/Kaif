import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inspireui/inspireui.dart';
import 'package:provider/provider.dart';

import '../../../common/config.dart';
import '../../../common/tools.dart';
import '../../../common/tools/biometrics_tools.dart';
import '../../../data/boxes.dart';
import '../../../generated/l10n.dart';
import '../../../models/index.dart';
import '../../../services/index.dart';
import '../../../widgets/auth/social_login_button_row.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../../../widgets/common/flux_image.dart';
import '../../../widgets/common/login_animation.dart';
import '../../base_screen.dart';
import 'mixins/mixin_animation_button_login.dart';
import 'mixins/mixin_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  BaseScreen<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends BaseScreen<LoginScreen>
    with TickerProviderStateMixin, AnimationButtonLoginMixin, LoginMixin {
  late BuildContext _parentContext;

  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  Future _biometricsLogin(BuildContext context) async {
    var didAuth = await BiometricsTools.instance.localAuth(context);
    if (didAuth) {
      usernameCtrl.text = BiometricsBox().username ?? '';
      passwordCtrl.text = BiometricsBox().password ?? '';
      _onTapLogin();
    }
  }

  void _onTapLogin() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    runLogin(context);
  }

  @override
  TextEditingController passwordCtrl = TextEditingController();

  @override
  TextEditingController usernameCtrl = TextEditingController();

  @override
  Future<void> beforeCallLogin() => playAnimation();

  @override
  Future<void> afterCallLogin(bool isLoginSuccess) => stopAnimation();

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _parentContext = context;
    final appModel = Provider.of<AppModel>(context);
    final screenSize = MediaQuery.of(context).size;
    final themeConfig = appModel.themeConfig;
    var forgetPasswordUrl = ServerConfig().forgetPassword;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        actions: !Services().widget.isRequiredLogin &&
                !ModalRoute.of(context)!.canPop
            ? [
                IconButton(
                  onPressed: loginDone,
                  icon: const Icon(Icons.close, size: 25),
                )
              ]
            : null,
      ),
      body: SafeArea(
        child: AutoHideKeyboard(
          child: IgnorePointer(
            ignoring: isLoading,
            child: Center(
              child: Consumer<UserModel>(
                builder: (context, model, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    alignment: Alignment.center,
                    width: screenSize.width /
                        (2 / (screenSize.height / screenSize.width)),
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: AutofillGroup(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              child: FluxImage(
                                imageUrl: themeConfig.logo,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 20.0),
                                  CustomTextField(
                                    key: const Key('loginEmailField'),
                                    controller: usernameCtrl,
                                    autofillHints: const [AutofillHints.email],
                                    showCancelIcon: true,
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    nextNode: _usernameFocusNode,
                                    decoration: InputDecoration(
                                      labelText: S.of(_parentContext).username,
                                      hintText: S
                                          .of(_parentContext)
                                          .enterYourEmailOrUsername,
                                    ),
                                  ),
                                  CustomTextField(
                                    key: const Key('loginPasswordField'),
                                    autofillHints: const [
                                      AutofillHints.password
                                    ],
                                    obscureText: true,
                                    showEyeIcon: true,
                                    textInputAction: TextInputAction.done,
                                    controller: passwordCtrl,
                                    focusNode: _passwordFocusNode,
                                    decoration: InputDecoration(
                                      labelText: S.of(_parentContext).password,
                                      hintText: S
                                          .of(_parentContext)
                                          .enterYourPassword,
                                    ),
                                  ),
                                  if (kLoginSetting.isResetPasswordSupported)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          launchForgetPasswordURL(
                                              forgetPasswordUrl);
                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            S.of(context).resetPassword,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (!kLoginSetting.isResetPasswordSupported)
                                    const SizedBox(height: 50.0),
                                  StaggerAnimation(
                                    key: const Key('loginSubmitButton'),
                                    titleButton: S.of(context).signInWithEmail,
                                    buttonController: loginButtonController.view
                                        as AnimationController,
                                    onTap: () =>
                                        isLoading ? null : _onTapLogin(),
                                  ),
                                  if (BiometricsTools.instance.isLoginSupported)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: IconButton(
                                        iconSize: 50,
                                        onPressed: () =>
                                            _biometricsLogin(context),
                                        icon: const Icon(
                                            Icons.fingerprint_outlined),
                                      ),
                                    ),
                                  Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: <Widget>[
                                      SizedBox(
                                          height: 50.0,
                                          width: 200.0,
                                          child: Divider(
                                              color: Colors.grey.shade300)),
                                      Container(
                                          height: 30,
                                          width: 40,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                      if (kLoginSetting.showFacebook ||
                                          kLoginSetting.showSMSLogin ||
                                          kLoginSetting.showGoogleLogin ||
                                          kLoginSetting.showAppleLogin)
                                        Text(
                                          S.of(context).or,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade400),
                                        )
                                    ],
                                  ),
                                  SocialLoginButtonRow(
                                    onApplePressed: () =>
                                        loginWithApple(context),
                                    onFacebookPressed: () =>
                                        loginWithFacebook(context),
                                    onGooglePressed: () =>
                                        loginWithGoogle(context),
                                    onSmsPressed: () => loginWithSMS(context),
                                  ),
                                  const SizedBox(height: 30.0),
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(S.of(context).dontHaveAccount),
                                          GestureDetector(
                                            onTap: () {
                                              NavigateTools.navigateRegister(
                                                  context);
                                            },
                                            child: Text(
                                              ' ${S.of(context).signup}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
