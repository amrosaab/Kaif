import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/config.dart';
import '../../common/config/models/notification_request_screen_config.dart';
import '../../common/constants.dart';
import '../../common/tools/navigate_tools.dart';
import '../../data/boxes.dart';
import '../../generated/l10n.dart';
import '../../models/notification_model.dart';
import '../../services/services.dart';
import '../../widgets/common/flux_image.dart';
import '../common/permission_request_mixin.dart';

class NotificationRequestScreen extends StatefulWidget {
  const NotificationRequestScreen({Key? key}) : super(key: key);

  @override
  State<NotificationRequestScreen> createState() =>
      _NotificationRequestScreenState();
}

class _NotificationRequestScreenState extends State<NotificationRequestScreen>
    with PermissionRequestMixin {
  NotificationModel get _notificationModel => context.read<NotificationModel>();

  NotificationRequestScreenConfig get config =>
      kNotificationRequestScreenConfig;

  String get defaultImage => 'assets/images/get_notified.json';

  String get imageUrl {
    var value = config.image;
    if (value != null && value.isNotEmpty) {
      return value;
    }
    return defaultImage;
  }

  @override
  IconData get permissionIcon => CupertinoIcons.bell_fill;

  @override
  String get permissionRequestTitle => S.of(context).notifyLatestOffer;

  @override
  String get permissionRequestSubtitle =>
      S.of(context).weWillSendYouNotification;

  @override
  Future<void> onAcceptPermission() async {
    await _notificationModel.enableNotification();
    _gotoNextScreen();
  }

  @override
  Future<void> onDeclinePermission() async {
    _notificationModel.disableNotification();
    _gotoNextScreen();
  }

  void _gotoNextScreen() {
    SettingsBox().hasFinishedOnboarding = true;
    if (Services().widget.isRequiredLogin) {
      NavigateTools.navigateToLogin(
        context,
        replacement: true,
      );
      return;
    }
    if (kAdvanceConfig.gdprConfig.showPrivacyPolicyFirstTime) {
      Navigator.of(context).pushReplacementNamed(
        RouteList.privacyTerms,
      );
    } else {
      Navigator.of(context).pushReplacementNamed(RouteList.dashboard);
    }
  }

  Widget renderIcon({double size = 48}) {
    var icon = config.icon;
    if (icon != null && icon.isNotEmpty) {
      return FluxImage(
        imageUrl: icon,
        height: size,
        fit: BoxFit.scaleDown,
      );
    }
    return Icon(
      permissionIcon,
      size: size,
      color: Colors.amber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  renderIcon(),
                  const SizedBox(height: 8),
                  Text(
                    config.title ?? S.of(context).getNotified,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    config.desc ?? permissionRequestSubtitle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                flex: 3,
                child: FluxImage(
                  imageUrl: imageUrl,
                  alignment: Alignment.center,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  TextButton(
                    onPressed: onDeclinePermission,
                    child: Text(S.of(context).skip),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: onAcceptPermission,
                    child: Text(
                      S.of(context).imIn,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
