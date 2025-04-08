import 'dart:async';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:country_pickers/country.dart' as picker_country;
import 'package:country_pickers/country_pickers.dart' as picker;
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:fstore/common/config/models/country_address_fields_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../../common/config.dart';
import '../../../common/config/models/address_field_config.dart';
import '../../../common/constants.dart';
import '../../../common/tools/flash.dart';
import '../../../data/boxes.dart';
import '../../../generated/l10n.dart';
import '../../../models/index.dart'
    show Address, AppModel, CartModel, City, Country, CountryState, UserModel;
import '../../../services/index.dart';
import '../../../widgets/common/common_safe_area.dart';
import '../../../widgets/common/flux_image.dart';
import '../../../widgets/common/place_picker.dart';
import '../choose_address_screen.dart';
import 'selected_country_model.dart';

part 'shipping_address_extension.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({this.onNext});

  final Function? onNext;

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  late final selectedCountryModel =
      Provider.of<SelectedCountryModel>(context, listen: false);

  String get langCode => Provider.of<AppModel>(context, listen: false).langCode;

  final _formKey = GlobalKey<FormState>();

  final Map<int, AddressFieldType> _fieldsPositions = {};

  final Map<int, AddressFieldConfig> _fieldsConfigs = {};

  final Map<AddressFieldType, TextEditingController> _textControllers = {};

  final Map<AddressFieldType, FocusNode> _focusNodes = {};

  CountryAddressFieldsConfig? countryFields;

  Address? address;
  List<Country>? countries = [];
  List<CountryState>? states = [];
  List<City>? cities = [];

  PhoneNumber? initialPhoneNumber;

  @override
  void initState() {
    super.initState();

    /// Init fields.
    initializeFields();

    /// Pre-fill the address fields.
    WidgetsBinding.instance.endOfFrame.then(
      (_) async {
        await preFillData();
      },
    );

    selectedCountryModel.addListener(selectedIsoCodeListener);
  }

  @override
  void dispose() {
    disposeOldData();
    super.dispose();
  }

  void disposeOldData() {
    address = null;

    refresh();

    _fieldsPositions.clear();
    _fieldsConfigs.clear();

    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    _textControllers.clear();

    for (var focusNode in _focusNodes.values) {
      focusNode.dispose();
    }
    _focusNodes.clear();
  }

  void initializeFields() {
    countryFields = Configurations.addressFields.firstWhereOrNull(
      (element) => element.country == selectedCountryModel.selectedIsoCode,
    );

    for (var oneAddressField
        in countryFields?.addressFields ?? DefaultConfig.addressFields) {
      final index = _fieldsPositions.values.length;
      _fieldsConfigs[index] = oneAddressField;
      _fieldsPositions[index] = oneAddressField.type;
      _textControllers[oneAddressField.type] = TextEditingController();
      _focusNodes[oneAddressField.type] = FocusNode();
    }
  }

  Future<void> preFillData() async {
    /// Load saved addresses.
    final addressValue =
        await Provider.of<CartModel>(context, listen: false).getAddress(
      selectedCountryModel.selectedIsoCode,
    );
    if (addressValue != null) {
      updateAddress(addressValue);
    } else {
      var user = Provider.of<UserModel>(context, listen: false).user;
      setState(() {
        address = Address(country: kPaymentConfig.defaultCountryISOCode);
        if (kPaymentConfig.defaultStateISOCode != null) {
          address!.state = kPaymentConfig.defaultStateISOCode;
        }
        _textControllers[AddressFieldType.country]?.text = address!.country!;
        _textControllers[AddressFieldType.state]?.text = address!.state!;
        if (user != null) {
          address!.firstName = user.firstName;
          address!.lastName = user.lastName;
          address!.email = user.email;
          loadUserInfoFromAddress(address);
        }
      });
    }

    address = address?.copyWith(
            country: () => selectedCountryModel.selectedIsoCode) ??
        Address(country: selectedCountryModel.selectedIsoCode);

    /// Init default fields.
    for (var field in _fieldsConfigs.values) {
      if ([
        AddressFieldType.searchAddress,
        AddressFieldType.selectAddress,
        AddressFieldType.state,
      ].contains(field.type)) {
        /// Not support default value.
        continue;
      }

      /// Replace current value with default value.
      /// Force to use default value for non-editable field.
      if (field.defaultValue.isNotEmpty && !field.editable) {
        _textControllers[field.type]?.text = field.defaultValue;
        onTextFieldSaved(field.defaultValue, field.type);
      }

      /// When the field is editable, replacing only when it's empty.
      if (field.defaultValue.isNotEmpty &&
          field.editable &&
          (_textControllers[field.type]?.text.isEmpty ?? false)) {
        _textControllers[field.type]?.text = field.defaultValue;
        onTextFieldSaved(field.defaultValue, field.type);
      }
    }

    if (kPhoneNumberConfig.enablePhoneNumberValidation) {
      /// Load phone number.
      try {
        final phoneNumber =
            _textControllers[AddressFieldType.phoneNumber]?.text.trim();
        // if (phoneNumber?.isNotEmpty ?? false) {
        //   initialPhoneNumber = await PhoneNumber.getParsablePhoneNumber(
        //     PhoneNumber(
        //       dialCode: selectedCountryModel.dialCode,
        //       isoCode: selectedCountryModel.selectedIsoCode,
        //       phoneNumber: phoneNumber,
        //     ),
        //   );
        // } else {
          initialPhoneNumber = PhoneNumber(
            dialCode: selectedCountryModel.dialCode,
            isoCode: selectedCountryModel.selectedIsoCode,
          );
       // }
        refresh();
      } catch (e, trace) {
        printError(e, trace);
      }
    }

    /// Load country list.
    // countries = await Services().widget.loadCountries();
    var country = countries!.firstWhereOrNull(
      (element) =>
          element.code!.toUpperCase() == selectedCountryModel.selectedIsoCode,
    );
    if (country == null) {
      if (countries!.isNotEmpty) {
        country = countries![0];
        address!.country = countries![0].code;
      } else {
        country = Country.fromConfig(address!.country, null, null, []);
      }
    } else {
      address!.country = country.code;
      address!.countryId = country.id;
    }
    _textControllers[AddressFieldType.country]?.text = country.code!;
    refresh();

    /// Load states.
    states = await Services().widget.loadStates(country, langCode);
    refresh();

    /// Load cities.
    var state = states?.firstWhereOrNull(
      (element) =>
          element.id == address?.state || element.code == address?.state,
    );
      cities = states?.map((e) => e.toCity()).toList();
      var city = cities?.firstWhereOrNull(
        (element) => element.name == address?.city,
      );

      /// Load zipCode
      if (city != null) {
        var zipCode = await Services().widget.loadZipCode(country, CountryState(), city);
        if (zipCode != null) {
          /// Override the default value with this value
          address!.zipCode = zipCode;
          _textControllers[AddressFieldType.zipCode]?.text = zipCode;
        }
      }
      refresh();
  }

  void selectedIsoCodeListener() async {
    final isoCode = selectedCountryModel.selectedIsoCode;
    if (isoCode != address?.country) {
      disposeOldData();
      initializeFields();
      await Future.delayed(const Duration(seconds: 1));
      await preFillData();
      refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    var countryName = S.of(context).country;
    final currentCountry =
        _textControllers[AddressFieldType.country]?.text ?? '';
    if (currentCountry.isNotEmpty) {
      try {
        if (countries?.isEmpty ?? true) {
          countryName =
              picker.CountryPickerUtils.getCountryByIsoCode(currentCountry)
                  .name;
        } else {
          countryName = countries!
              .firstWhere((element) => element.code == currentCountry)
              .name!;
        }
      } catch (e) {
        countryName = S.of(context).country;
      }
    }

    if (address == null) {
      return SizedBox(height: 100, child: kLoadingWidget(context));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 50.0,
              ),
              child: Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Selector<SelectedCountryModel, String>(
                      selector: (_, model) => model.selectedIsoCode,
                      builder: (_, selectedIsoCode, __) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: buildTextFields(countryName),
                        );
                      }),
                ),
              ),
            ),
          ),
        ),
        _buildBottom(),
      ],
    );
  }

  List<Widget> buildTextFields(String countryName) {
    return List.generate(
      _fieldsPositions.length,
      (index) {
        final isVisible = _fieldsConfigs[index]?.visible ?? true;
        if (!isVisible) {
          return const SizedBox();
        }

        final currentFieldType =
            _fieldsPositions[index] ?? AddressFieldType.unknown;

        if (currentFieldType == AddressFieldType.state &&
            (states?.isNotEmpty ?? false)) {
          return renderStateInput();
        }

        if (currentFieldType == AddressFieldType.city &&
            (cities?.isNotEmpty ?? false)) {
          return renderCityInput(index);
        }

        if (currentFieldType == AddressFieldType.searchAddress) {
          if (kPaymentConfig.allowSearchingAddress &&
              kGoogleApiKey.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonTheme(
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.secondary,
                          backgroundColor: Theme.of(context).primaryColorLight,
                          elevation: 0.0,
                        ),
                        onPressed: () async {
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                kIsWeb
                                    ? kGoogleApiKey.web
                                    : isIos
                                        ? kGoogleApiKey.ios
                                        : kGoogleApiKey.android,
                              ),
                            ),
                          );

                          if (result is LocationResult) {
                            address!.country = result.country;
                            address!.street = result.street;
                            address!.state = result.state;
                            address!.city = result.city;
                            address!.zipCode = result.zip;
                            if (result.latLng?.latitude != null &&
                                result.latLng?.latitude != null) {
                              address!.mapUrl =
                                  'https://maps.google.com/maps?q=${result.latLng?.latitude},${result.latLng?.longitude}&output=embed';
                              address!.latitude =
                                  result.latLng?.latitude.toString();
                              address!.longitude =
                                  result.latLng?.longitude.toString();
                            }

                            loadAddressFields(address);
                            final c = Country(
                                id: result.country, name: result.country);
                            states =
                                await Services().widget.loadStates(c, langCode);
                            setState(() {});
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              CupertinoIcons.arrow_up_right_diamond,
                              size: 18,
                            ),
                            const SizedBox(width: 10.0),
                            Text(S.of(context).searchingAddress.toUpperCase()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        }

        if (currentFieldType == AddressFieldType.selectAddress) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ButtonTheme(
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).primaryColorLight
                          : Colors.grey[300],
                  elevation: 0.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseAddressScreen((address){
                        phoneNumecode=address!.country!;
                        selectedCountryModel.selectedIsoCode=phoneNumecode;
                        _fieldsConfigs.clear();
                        _fieldsPositions.clear();
                        _textControllers.clear();
                        _focusNodes.clear();
                        // disposeOldData();
                        initializeFields();
                        preFillData();
                      }),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                color: Colors.grey,
                      CupertinoIcons.person_crop_square,
                      size: 16,
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      S.of(context).selectAddress.toUpperCase(),
                        style:Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey)
                        //     color:
                        // Theme.of(context).brightness == Brightness.dark? Theme.of(context).colorScheme.secondary: Theme.of(context).colorScheme.primary),


              ),
                  ],
                ),
              ),
            ),
          );
        }

        final currentFieldController = _textControllers[currentFieldType];
        final currentFieldFocusNode = _focusNodes[currentFieldType];

        var hasNext = false;
        var nextFieldIndex = index + 1;
        late var nextFieldType;
        late var nextFieldFocus;
        while (nextFieldIndex < _fieldsPositions.length) {
          nextFieldType = _fieldsPositions[nextFieldIndex];
          nextFieldFocus = _focusNodes[nextFieldType];
          if (nextFieldType == AddressFieldType.country ||
              (nextFieldType == AddressFieldType.state &&
                  (states?.isNotEmpty ?? false)) ||
              (nextFieldType == AddressFieldType.city &&
                  (cities?.isNotEmpty ?? false))) {
            hasNext = false;
            break;
          }
          if (nextFieldFocus != null) {
            hasNext = true;
            break;
          }
          nextFieldIndex++;
        }

        if (currentFieldType == AddressFieldType.phoneNumber &&
            kPhoneNumberConfig.enablePhoneNumberValidation) {
          return InternationalPhoneNumberInput(
            /// Auto focus first field if it's empty.
            autoFocus:
                index == 0 && (currentFieldController?.text.isEmpty ?? false),
            textFieldController: currentFieldController,
            focusNode: currentFieldFocusNode,
            //hokshedit
            // isReadOnly: isFieldReadOnly(index),
            autofillHints: currentFieldType.autofillHint != null
                ? ['${currentFieldType.autofillHint}']
                : null,
            inputDecoration: InputDecoration(
              labelText: getFieldLabel(currentFieldType),
            ),
            keyboardType: getKeyboardType(currentFieldType),
            keyboardAction:
                hasNext ? TextInputAction.next : TextInputAction.done,

            onFieldSubmitted: (_) {
              if (hasNext) {
                nextFieldFocus?.requestFocus();
              }
            },
            validator: (val) {
              final fieldConfig = _fieldsConfigs[index];
              if (fieldConfig == null) {
                return null;
              }
              return validateField(val, fieldConfig, currentFieldType);
            },
            onSaved: (value) {
              onTextFieldSaved(
                value.phoneNumber?.replaceFirst(value.dialCode ?? '', ''),
                currentFieldType,
              );
            },
            onInputChanged: selectedCountryModel.onInputChanged,
            onInputValidated: (value) {},
            spaceBetweenSelectorAndTextField: 0,
            selectorConfig: SelectorConfig(
              //hokshedit
              // enable: kPhoneNumberConfig.useInternationalFormat,
              showFlags: kPhoneNumberConfig.showCountryFlag,
              selectorType: kPhoneNumberConfig.selectorType,
              setSelectorButtonAsPrefixIcon:
                  kPhoneNumberConfig.selectorFlagAsPrefixIcon,
              leadingPadding: 0,
              trailingSpace: true,
            ),
            selectorTextStyle: Theme.of(context).textTheme.titleMedium,
            ignoreBlank: !(_fieldsConfigs[index]?.required ?? true),
            initialValue: initialPhoneNumber,
            formatInput: kPhoneNumberConfig.formatInput,
            countries: kPhoneNumberConfig.customCountryList,
            locale: langCode,
            searchBoxDecoration: InputDecoration(
              labelText: S.of(context).searchByCountryNameOrDialCode,
            ),
          );
        }

        return TextFormField(
          /// Auto focus first field if it's empty.
          autofocus:
              index == 0 && (currentFieldController?.text.isEmpty ?? false),
          autocorrect: false,
          controller: currentFieldController,
          focusNode: currentFieldFocusNode,
          readOnly: isFieldReadOnly(index),
          autofillHints: currentFieldType.autofillHint != null
              ? ['${currentFieldType.autofillHint}']
              : null,
          decoration: InputDecoration(
            labelText: getFieldLabel(currentFieldType),
            prefixStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
          keyboardType: getKeyboardType(currentFieldType),
          textCapitalization: TextCapitalization.words,
          textInputAction:
              hasNext ? TextInputAction.next : TextInputAction.done,
          validator: (val) {
            final fieldConfig = _fieldsConfigs[index];
            if (fieldConfig == null) {
              return null;
            }
            return validateField(val, fieldConfig, currentFieldType);
          },
          onFieldSubmitted: (_) {
            if (hasNext) {
              nextFieldFocus?.requestFocus();
            }
          },
          onSaved: (value) => onTextFieldSaved(
            value,
            currentFieldType,
          ),
        );
      },
    );
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}