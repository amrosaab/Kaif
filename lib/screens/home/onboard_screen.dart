import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:provider/provider.dart';

import '../../common/config.dart' as config;
import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/tools/navigate_tools.dart';
import '../../data/boxes.dart';
import '../../generated/l10n.dart';
import '../../models/index.dart' show AppModel;
import '../../models/notification_model.dart';
import '../../services/services.dart';
import '../../widgets/common/flux_image.dart';
import 'change_language_mixin.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen();

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> with ChangeLanguage {
  final isRequiredLogin = config.kLoginSetting.isRequiredLogin;
  int page = 0;

  NotificationModel get _notificationModel =>
      Provider.of<NotificationModel>(context, listen: false);
  void setHasSeen() {
    SettingsBox().hasFinishedOnboarding = true;
  }

  void _onTapSignIn() async {
    setHasSeen();
    await NavigateTools.navigateToLogin(context, replacement: true);
  }

  void onTapDone() async {
    if (Services().widget.isRequiredLogin) {
      return;
    }
    if (SettingsBox().hasFinishedOnboarding) {
      await Navigator.pushReplacementNamed(context, RouteList.dashboard);
      return;
    }
    setHasSeen();

    if (kAdvanceConfig.showRequestNotification) {
      await Navigator.of(context)
          .pushReplacementNamed(RouteList.notificationRequest);
      return;
    }
    await _notificationModel.enableNotification();
    if (kAdvanceConfig.gdprConfig.showPrivacyPolicyFirstTime) {
      await Navigator.of(context).pushReplacementNamed(
        RouteList.privacyTerms,
      );
    } else {
      await Navigator.of(context).pushReplacementNamed(RouteList.dashboard);
    }
  }

  List<ContentConfig> getSlides(List<dynamic> data) {
    final slides = <ContentConfig>[];

    Widget renderLoginWidget(String imagePath) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FluxImage(
            imageUrl: imagePath,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: _onTapSignIn,
                  child: Text(
                    S.of(context).signIn,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Text(
                  '    |    ',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 20.0),
                ),
                GestureDetector(
                  onTap: () async {
                    setHasSeen();
                    NavigateTools.navigateRegister(
                      context,
                      replacement: true,
                    );
                  },
                  child: Text(
                    S.of(context).signUp,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    for (var i = 0; i < data.length; i++) {
      final isLastItem = i == data.length - 1;

      var slide = ContentConfig(
          title: data[i]['title'],
          description: data[i]['desc'],
          marginTitle: const EdgeInsets.only(
            top: 100.0,
            bottom: 50.0,
          ),
          maxLineTextDescription: 2,
          styleTitle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: kGrey900,
          ),
          backgroundColor: Colors.white,
          marginDescription: const EdgeInsets.fromLTRB(20.0, 75.0, 20.0, 0),
          styleDescription: const TextStyle(
            fontSize: 15.0,
            color: kGrey600,
          ),
          foregroundImageFit: BoxFit.fitWidth,
          centerWidget: isLastItem
              ? renderLoginWidget(data[i]['image'])
              : FluxImage(
                  imageUrl: data[i]['image'],
                  fit: BoxFit.fitWidth,
                ));
      slides.add(slide);
    }
    return slides;
  }

  @override
  Widget build(BuildContext context) {
    final data = config.onBoardingData;
    final isRequiredLogin = Services().widget.isRequiredLogin;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          IntroSlider(
            listContentConfig: getSlides(data),
            renderSkipBtn:
                MultiLanguageTextButton(getText: () => S.of(context).skip),
            renderDoneBtn: MultiLanguageTextButton(
                getText: () => isRequiredLogin ? '' : S.of(context).done),
            renderPrevBtn:
                MultiLanguageTextButton(getText: () => S.of(context).prev),
            renderNextBtn:
                MultiLanguageTextButton(getText: () => S.of(context).next),
            isShowDoneBtn: !isRequiredLogin,
            onDonePress: onTapDone,
          ),
          iconLanguage(),
        ],
      ),
    );
  }
}

class MultiLanguageTextButton extends StatelessWidget {
  const MultiLanguageTextButton({Key? key, required this.getText})
      : super(key: key);
  final String Function() getText;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, _, __) {
      return Text(
        getText(),
        style: TextStyle(color: Theme.of(context).primaryColor),
      );
    });
  }
}
