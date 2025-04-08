import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../common/config.dart';
import '../../common/config/models/notification_request_screen_config.dart';
import '../../common/constants.dart';
import '../../common/tools/flash.dart';
import '../../common/tools/navigate_tools.dart';
import '../../data/boxes.dart';
import '../../generated/l10n.dart';
import '../../models/app_model.dart';
import '../../models/entities/currency.dart';
import '../../models/notification_model.dart';
import '../../services/service_config.dart';
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
  bool isUpdating = false;
  final currencies = kAdvanceConfig.currencies;
  final ValueNotifier<List<Currency>?> _availableCurrenciesNotifier =
  ValueNotifier<List<Currency>?>(null);
  Currency? currencyDisplay;

  Future<void> getCurrency() async {
    final currencies = await Services().api.getAvailableCurrencies();
    _availableCurrenciesNotifier.value = currencies;
  }


  @override
  void initState() {
    super.initState();
    currencyDisplay =currencies.firstWhere((element) => element.countryCode==  Provider.of<AppModel>(context, listen: false).currencyCode);


    getCurrency();
  }



  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];
    var languages = getLanguages();
    final currentLanguage =
        Provider.of<AppModel>(context, listen: false).langCode;

    for (var i = 0; i < languages.length; i++) {
      if (ServerConfig().isVendorManagerType()) {
        if (unsupportedLanguages
            .contains(languages[i]['code'])) {
          continue;
        }
      }
      final isSelected = currentLanguage == languages[i]['code'];
      list.add(
          Flexible(

            // width:MediaQuery.of(context).size.width/2,
            child:InkWell(
              onTap: isUpdating?null: (){

                if (isSelected) {
                  return;
                }
                setState(() {
                  isUpdating = true;
                });
                Provider.of<AppModel>(context, listen: false)
                    .changeLanguage(
                  languages[i]['code'],
                  context,
                )
                    .then((_) {
                  setState(() {
                    isUpdating = false;
                  });
                  FlashHelper.message(
                    context,
                    message: S.of(context).languageSuccess,
                  );
                });
              },
              child:Container(

                margin: EdgeInsets.symmetric(horizontal: 10),

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),

                    color:isSelected? Theme.of(context).colorScheme.primary.withOpacity(.5):Colors.grey.withOpacity(.2)

                ),
                child: Row(
                  children: [
                    Checkbox(

                      activeColor:Theme.of(context).colorScheme.primary ,
                      fillColor: MaterialStateProperty.all(isSelected?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.background),
                      side: BorderSide(color: Colors.grey.withOpacity(.3),width: 2),
                      shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(5)),

                      value: isSelected, onChanged:isUpdating?null: (checked){

                      if (isSelected) {
                        return;
                      }
                      setState(() {
                        isUpdating = true;
                      });
                      Provider.of<AppModel>(context, listen: false)
                          .changeLanguage(
                        languages[i]['code'],
                        context,
                      )
                          .then((_) {
                        setState(() {
                          isUpdating = false;
                        });
                        FlashHelper.message(
                          context,
                          message: S.of(context).languageSuccess,
                        );
                      });
                    },
                    ),
                    Text(languages[i]['text'],style: Theme.of(context).textTheme.titleLarge,) ,
                  ],
                ) ,)


              ,)



            ,
          )


        // ListTile(
        //
        //
        //
        //   leading: FluxImage(
        //     imageUrl: languages[i]['icon'],
        //     width: 30,
        //     height: 20,
        //     fit: BoxFit.cover,
        //   ),
        //   title: Text(languages[i]['text']),
        //   onTap: isUpdating
        //       ? null
        //       : () {
        //     if (isSelected) {
        //       return;
        //     }
        //     setState(() {
        //       isUpdating = true;
        //     });
        //     Provider.of<AppModel>(context, listen: false)
        //         .changeLanguage(
        //       languages[i]['code'],
        //       context,
        //     )
        //         .then((_) {
        //       setState(() {
        //         isUpdating = false;
        //       });
        //       FlashHelper.message(
        //         context,
        //         message: S.of(context).languageSuccess,
        //       );
        //     });
        //   },
        //   trailing: !isSelected
        //       ? null
        //       : Icon(
        //     Icons.check,
        //     color: Theme.of(context).primaryColor,
        //   ),
        // ),
      );

      // if (i < languages.length - 1) {
      //   list.add(
      //     Divider(
      //       color: Theme.of(context).primaryColorLight,
      //       height: 1.0,
      //       indent: 75,
      //       endIndent: 30,
      //     ),
      //   );
      // }
    }

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
                  // renderIcon(),
                  Image.asset(
//////

                      color: Theme.of(context).colorScheme.primary,
                      // width: 300,
                      // height: 300,
                      'assets/images/iconlogo.png'),
                  const SizedBox(height: 8),
                  // Text(
                  //   config.title ?? S.of(context).getNotified,
                  //   textAlign: TextAlign.center,
                  //   style: Theme.of(context).textTheme.headlineSmall,
                  // ),
                  Text(
                    config.title ?? S.of(context).lang,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child:   Row

                      (

                      children: [    ...list],),
                  )


                  ,
                  const SizedBox(height: 30),


                  Text(
                    config.title ?? S.of(context).con,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 30),

                  ValueListenableBuilder(
                    valueListenable: _availableCurrenciesNotifier,
                    builder: (_, availableCurrencies, __) {
                      if (availableCurrencies == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final supportedCurrencies = availableCurrencies.isEmpty
                          ? currencies
                          : currencies.where((element) => availableCurrencies
                          .any((e) => e.countryCode == element.countryCode));

                      // final unsupportedCurrencies = currencies
                      //     .where((element) => !supportedCurrencies.contains(element));

                      // final allCurrencies = [
                      //   ...supportedCurrencies,
                      //   ...unsupportedCurrencies
                      // ];
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          // padding: EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(color: Colors.grey.withOpacity(.2)),
                          ),
                          child:

                          DropdownButton<Currency>(
                            value: currencyDisplay,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            // icon:,
                            elevation: 16,

                            // style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 0,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (Currency? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                currencyDisplay = value!;
                                Provider.of<AppModel>(context, listen: false)
                                    .changeCurrency(context, currencyDisplay!);

                                FlashHelper.message(
                                  context,
                                  message: S.of(context).changedCurrencyTo(
                                    currencyDisplay!.currencyDisplay,
                                  ),
                                );
                              });
                            },
                            items: supportedCurrencies.map<DropdownMenuItem<Currency>>((Currency value) {
                              return DropdownMenuItem<Currency>(
                                value: value,
                                child: Text("${value.currencyDisplay} (${value.symbol})"),
                              );
                            }).toList(),
                          ));
                    },
                  )
                  // Text(
                  //   config.desc ?? permissionRequestSubtitle,
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
              Spacer(),
              Row(
                children: [              Expanded(child:   ElevatedButton(
                  style: ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(30)
                      ))),
                  onPressed: onAcceptPermission,
                  child: Text(
                      S.of(context).shopnoww.toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white)
                  ),
                ))
                ],
              ),
              Spacer()
              ,
              // Expanded(
              //   flex: 3,
              //   child: FluxImage(
              //     imageUrl: imageUrl,
              //     alignment: Alignment.center,
              //   ),
              // ),
              // const Spacer(),
              // Row(
              //   children: [
              //     TextButton(
              //       onPressed: onDeclinePermission,
              //       child: Text(S.of(context).skip),
              //     ),
              //     const Spacer(),
              //     ElevatedButton(
              //       onPressed: onAcceptPermission,
              //       child: Text(
              //         S.of(context).imIn,
              //         style: const TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
