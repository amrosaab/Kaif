import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
import '../../../common/tools.dart';
import '../../../generated/l10n.dart';
import '../../../models/index.dart' show AppModel;
import '../../../screens/home/privacy_term_screen.dart';
import '../../../services/services.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../../../widgets/common/flux_image.dart';
import '../models/role.dart';
import '../services/index.dart';

class WholesaleSignUpScreen extends StatefulWidget {
  const WholesaleSignUpScreen();

  @override
  State<WholesaleSignUpScreen> createState() => _WholesaleSignUpScreenState();
}

class _WholesaleSignUpScreenState extends State<WholesaleSignUpScreen> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _emailController = TextEditingController();
  final _services = MembershipServices();

  List<WholesaleRole>? _roles;
  String? _selectedRole;

  String? firstName, lastName, emailAddress, username, password;
  bool isChecked = false;
  bool isLoading = false;

  final firstNameNode = FocusNode();
  final lastNameNode = FocusNode();
  final usernameNode = FocusNode();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _roles = await _services.getRoles();
      setState(() {
        if (_roles?.isNotEmpty ?? false) {
          _selectedRole = _roles?.first.key;
        }
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    usernameNode.dispose();
    super.dispose();
  }

  void _snackBar(String text) {
    if (mounted) {
      final snackBar = SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 10),
        action: SnackBarAction(
          label: S.of(context).close,
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      _scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    }
  }

  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).registerSuccess),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(S.of(context).wholesaleRegisterMsg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void goBackLogin() {
    Navigator.of(context).popUntil(ModalRoute.withName(RouteList.login));
  }

  Future<void> _submitRegister(
      {String? firstName,
      String? lastName,
      String? emailAddress,
      String? password,
      String? username}) async {
    if (firstName == null ||
        lastName == null ||
        emailAddress == null ||
        password == null ||
        username == null) {
      _snackBar(S.of(context).pleaseInputFillAllFields);
    } else if (isChecked == false) {
      _snackBar(S.of(context).pleaseAgreeTerms);
    } else {
      if (!emailAddress.validateEmail()) {
        _snackBar(S.of(context).errorEmailFormat);
        return;
      }

      if (password.length < 8) {
        _snackBar(S.of(context).errorPasswordFormat);
        return;
      }

      try {
        setState(() {
          isLoading = true;
        });
        if (_selectedRole == 'vendor') {
          await Services().api.createUser(
                firstName: firstName,
                lastName: lastName,
                username: username,
                password: password,
                isVendor: true,
              );
        } else {
          await _services.signUp(
              username: username,
              email: emailAddress,
              firstName: firstName,
              lastName: lastName,
              password: password,
              selectedRole: _selectedRole);
        }

        if (_selectedRole != 'vendor' && _selectedRole != 'subscriber') {
          await _showSuccessDialog();
        }
        setState(() {
          isLoading = false;
        });
        goBackLogin();
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        _snackBar(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context, listen: true);
    final themeConfig = appModel.themeConfig;

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => Tools.hideKeyboard(context),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: AutofillGroup(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      Center(
                        child: FluxImage(
                          imageUrl: themeConfig.logo,
                          width: MediaQuery.of(context).size.width / 2,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      CustomTextField(
                        key: const Key('registerFirstNameField'),
                        autofillHints: const [AutofillHints.givenName],
                        onChanged: (value) => firstName = value,
                        textCapitalization: TextCapitalization.words,
                        nextNode: lastNameNode,
                        showCancelIcon: true,
                        decoration: InputDecoration(
                          labelText: S.of(context).firstName,
                          hintText: S.of(context).enterYourFirstName,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField(
                        key: const Key('registerLastNameField'),
                        autofillHints: const [AutofillHints.familyName],
                        focusNode: lastNameNode,
                        nextNode: usernameNode,
                        showCancelIcon: true,
                        textCapitalization: TextCapitalization.words,
                        onChanged: (value) => lastName = value,
                        decoration: InputDecoration(
                          labelText: S.of(context).lastName,
                          hintText: S.of(context).enterYourLastName,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField(
                        key: const Key('registerUsernameField'),
                        autofillHints: const [AutofillHints.familyName],
                        focusNode: usernameNode,
                        nextNode: emailNode,
                        showCancelIcon: true,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => username = value,
                        decoration:
                            InputDecoration(labelText: S.of(context).username),
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField(
                        key: const Key('registerEmailField'),
                        focusNode: emailNode,
                        autofillHints: const [AutofillHints.email],
                        nextNode: passwordNode,
                        controller: _emailController,
                        onChanged: (value) => emailAddress = value,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: S.of(context).enterYourEmail),
                        hintText: S.of(context).enterYourEmail,
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField(
                        key: const Key('registerPasswordField'),
                        focusNode: passwordNode,
                        autofillHints: const [AutofillHints.password],
                        showEyeIcon: true,
                        obscureText: true,
                        onChanged: (value) => password = value,
                        decoration: InputDecoration(
                          labelText: S.of(context).enterYourPassword,
                          hintText: S.of(context).enterYourPassword,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SelectRole(
                        roles: _roles ?? [],
                        value: _selectedRole,
                        onChanged: (val) {
                          setState(() {
                            _selectedRole = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            key: const Key('registerConfirmCheckbox'),
                            value: isChecked,
                            activeColor: Theme.of(context).primaryColor,
                            checkColor: Colors.white,
                            onChanged: (value) {
                              isChecked = !isChecked;
                              setState(() {});
                            },
                          ),
                          InkWell(
                            onTap: () {
                              isChecked = !isChecked;
                              setState(() {});
                            },
                            child: Text(
                              S.of(context).iwantToCreateAccount,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          isChecked = !isChecked;
                          setState(() {});
                        },
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              value: isChecked,
                              activeColor: Theme.of(context).primaryColor,
                              checkColor: Colors.white,
                              onChanged: (value) {
                                isChecked = !isChecked;
                                setState(() {});
                              },
                            ),
                            Expanded(
                              child: RichText(
                                maxLines: 2,
                                text: TextSpan(
                                  text: S.of(context).iAgree,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  children: <TextSpan>[
                                    const TextSpan(text: ' '),
                                    TextSpan(
                                      text: S.of(context).agreeWithPrivacy,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const PrivacyTermScreen(
                                                  navigateFromSignUp: true,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          elevation: 0,
                          child: MaterialButton(
                            key: const Key('registerSubmitButton'),
                            onPressed: isLoading == true
                                ? null
                                : () async {
                                    await _submitRegister(
                                        firstName: firstName,
                                        lastName: lastName,
                                        emailAddress: emailAddress,
                                        password: password,
                                        username: username);
                                  },
                            minWidth: 200.0,
                            elevation: 0.0,
                            height: 42.0,
                            child: Text(
                              isLoading == true
                                  ? S.of(context).loading
                                  : S.of(context).createAnAccount,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectRole extends StatelessWidget {
  final String? value;
  final Function? onChanged;
  final List<WholesaleRole> roles;

  const SelectRole({this.value, this.onChanged, required this.roles});

  @override
  Widget build(BuildContext context) {
    if (roles.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).selectRole,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        ...roles
            .map((role) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                          value: role.key ?? '',
                          groupValue: value,
                          onChanged: (val) {
                            onChanged!(val);
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(role.name ?? '',
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 5),
                            Text(role.desc ?? '')
                          ],
                        )
                      ]),
                ))
            .toList(),
      ],
    );
  }
}
