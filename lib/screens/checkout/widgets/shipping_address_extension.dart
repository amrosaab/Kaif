part of 'shipping_address.dart';

extension on _ShippingAddressState {
  void updateAddress(Address? newAddress) {
    address = newAddress;
    loadUserInfoFromAddress(newAddress);
    loadAddressFields(address);
  }

  void loadUserInfoFromAddress(Address? address) {
    _textControllers[AddressFieldType.firstName]?.text =
        address?.firstName?.trim() ?? '';
    _textControllers[AddressFieldType.lastName]?.text =
        address?.lastName?.trim() ?? '';
    _textControllers[AddressFieldType.phoneNumber]?.text =
        address?.phoneNumber?.trim() ?? '';
    _textControllers[AddressFieldType.email]?.text =
        address?.email?.trim() ?? '';
  }

  void loadAddressFields(Address? address) {
    _textControllers[AddressFieldType.country]?.text =
        address?.country?.trim() ?? '';
    _textControllers[AddressFieldType.state]?.text =
        address?.state?.trim() ?? '';
    _textControllers[AddressFieldType.city]?.text = address?.city?.trim() ?? '';
    _textControllers[AddressFieldType.block2]?.text = address?.block2?.trim() ?? '';
    _textControllers[AddressFieldType.apartment]?.text =
        address?.apartment?.trim() ?? '';
    _textControllers[AddressFieldType.block]?.text =
        address?.block?.trim() ?? '';
    _textControllers[AddressFieldType.street]?.text =
        address?.street?.trim() ?? '';
    _textControllers[AddressFieldType.zipCode]?.text =
        address?.zipCode?.trim() ?? '';
    refresh();
  }

  bool checkToSave() {
    var listAddress = <Address>[];
    var data = UserBox().addresses;
    if (data.isNotEmpty) {
      listAddress.addAll(data);
    }
    for (var local in listAddress) {
      final isNotExistedInLocal = local.city !=
          _textControllers[AddressFieldType.city]?.text ||
          local.street != _textControllers[AddressFieldType.street]?.text ||
          local.zipCode != _textControllers[AddressFieldType.zipCode]?.text ||
          local.state != _textControllers[AddressFieldType.state]?.text;
      if (isNotExistedInLocal) {
        continue;
      }
      showDialog(
        context: context,
        useRootNavigator: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).yourAddressExistYourLocal),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  S.of(context).ok,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              )
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  void saveDataToLocal() {
    var listAddress = <Address>[];
    final address = this.address;
    if (address != null) {
      listAddress.add(address);
    }
    var listData = UserBox().addresses;
    if (listData.isNotEmpty) {
      for (var item in listData) {
        listAddress.add(item);
      }
    }
    UserBox().addresses = listAddress;
    FlashHelper.message(
      context,
      message: S.of(context).yourAddressHasBeenSaved,
    );
  }

  String? validateEmail(String email) {
    if (email.isEmail) {
      return null;
    }
    return 'The E-mail Address must be a valid email address.';
  }

  String? validatePhoneNumber(String phoneNumber) {
    //TODO: Add to config
    const requiredLength = 8;
    if (phoneNumber.length == requiredLength) {
      return null;
    }
    return 'The Phone Number must be $requiredLength digits.';
  }

  /// Load Shipping beforehand
  void _loadShipping({bool beforehand = true}) {
    Services().widget.loadShippingMethods(
        context, Provider.of<CartModel>(context, listen: false), beforehand);
  }

  /// on tap to Next Button
  void _onNext() {
    {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        Provider.of<CartModel>(context, listen: false).setAddress(address);
        _loadShipping(beforehand: false);
        widget.onNext!();
      } else {
        FlashHelper.errorMessage(
          context,
          message: S.of(context).pleaseInput,
        );
      }
    }
  }

  Widget renderStateInput() {
    var items = <DropdownMenuItem>[];
    for (var item in states!) {
      items.add(
        DropdownMenuItem(
          value: item.id,
          child: Text(item.name ?? ''),
        ),
      );
    }
    String? value;

    Object? firstState = states!
        .firstWhereOrNull((o) => o.id.toString() == address!.state.toString());

    if (firstState != null) {
      value = address!.state;
    }
    return DropdownButton(
      items: items,
      value: value,
      onChanged: (dynamic val) async {
        address!.state = val;
        final country = Country(id: address!.country);
        final state = CountryState(id: val);
        cities = await Services().widget.loadCities(country, state);
        address!.zipCode = '';
        _textControllers[AddressFieldType.zipCode]?.text = '';
        refresh();
      },
      isExpanded: true,
      itemHeight: 70,
      hint: Text(S.of(context).stateProvince),
    );
  }

  Widget renderCityInput(int index) {
    var items = <DropdownMenuItem>[];
    for (var item in cities!) {
      items.add(
        DropdownMenuItem(
          value: item.id,
          child: Text(item.name!),
        ),
      );
    }
    String? value;

    Object? firstCity = cities!
        .firstWhereOrNull((o) => o.name.toString() == address!.city.toString());

    if (firstCity != null) {
      value = address!.city;
    }
    return DropdownButtonFormField<dynamic>(
      items: items,
      value: value,
      validator: (val) {
        final config = _configs[index];
        if (config == null) {
          return null;
        }
        return validateField(
            val, config, _fieldPosition[index] ?? AddressFieldType.unknown);
      },
      onChanged: (dynamic val) async {
        address!.city = val;
        final country = Country(id: address!.country);
        final state = CountryState(id: address!.state);
        final city = City(id: val, name: val);
        final zipCode =
        await Services().widget.loadZipCode(country, state, city);
        if (zipCode != null) {
          address!.zipCode = zipCode;
          _textControllers[AddressFieldType.zipCode]?.text = zipCode;
        }
        refresh();
      },
      isExpanded: true,
      itemHeight: 70,
      hint: Text(S.of(context).city),
    );
  }

  void _openCountryPickerDialog() => showDialog(
    context: context,
    useRootNavigator: false,
    builder: (contextBuilder) => countries!.isEmpty
        ? Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.pink),
      child: SizedBox(
        height: 500,
        child: picker.CountryPickerDialog(
          titlePadding: const EdgeInsets.all(8.0),
          contentPadding: const EdgeInsets.all(2.0),
          searchCursorColor: Colors.pinkAccent,
          searchInputDecoration:
          const InputDecoration(hintText: 'Search...'),
          isSearchable: true,
          title: Text(S.of(context).country),
          onValuePicked: (picker_country.Country country) async {
            _textControllers[AddressFieldType.country]?.text =
                country.isoCode;
            address!.country = country.isoCode;
            refresh();
            final c =
            Country(id: country.isoCode, name: country.name);
            states = await Services().widget.loadStates(c, langCode);
            address!.zipCode = '';
            _textControllers[AddressFieldType.zipCode]?.text = '';
            refresh();
          },
          itemBuilder: (country) {
            return Row(
              children: <Widget>[
                picker.CountryPickerUtils.getDefaultFlagImage(
                    country),
                const SizedBox(width: 8.0),
                Expanded(child: Text(country.name)),
              ],
            );
          },
        ),
      ),
    )
        : Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            countries!.length,
                (index) {
              return GestureDetector(
                onTap: () async {
                  _textControllers[AddressFieldType.country]?.text =
                  countries![index].code!;
                  address!.country = countries![index].id;
                  address!.countryId = countries![index].id;
                  refresh();
                  Navigator.pop(contextBuilder);
                  states = await Services()
                      .widget
                      .loadStates(countries![index], langCode);
                  address!.zipCode = '';
                  _textControllers[AddressFieldType.zipCode]?.text =
                  '';
                  refresh();
                },
                child: ListTile(
                  leading: countries![index].icon != null
                      ? SizedBox(
                    height: 40,
                    width: 60,
                    child: FluxImage(
                      imageUrl: countries![index].icon!,
                      fit: BoxFit.cover,
                    ),
                  )
                      : (countries![index].code != null
                      ? Image.asset(
                    picker.CountryPickerUtils
                        .getFlagImageAssetPath(
                        countries![index].code!),
                    height: 40,
                    width: 60,
                    fit: BoxFit.fill,
                    package: 'country_pickers',
                  )
                      : const SizedBox(
                    height: 40,
                    width: 60,
                    child: Icon(Icons.streetview),
                  )),
                  title: Text(countries![index].name!),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );

  void onTextFieldSaved(String? value, AddressFieldType type) {
    switch (type) {
      case AddressFieldType.firstName:
        address?.firstName = value;
        break;
      case AddressFieldType.lastName:
        address?.lastName = value;
        break;
      case AddressFieldType.phoneNumber:
        address?.phoneNumber = value;
        break;
      case AddressFieldType.email:
        address?.email = value;
        break;
      case AddressFieldType.country:
        address?.country = value;
        break;
      case AddressFieldType.state:
        address?.state = value;
        break;
      case AddressFieldType.city:
        address?.city = value;
        break;
      case AddressFieldType.apartment:
        address?.apartment = value;
        break;
      case AddressFieldType.block:
        address?.block = value;
        break;
      case AddressFieldType.block2:
        address?.block2 = value;
        break;
      case AddressFieldType.street:
        address?.street = value;
        break;
      case AddressFieldType.zipCode:
        address?.zipCode = value?.trim();
        break;

    /// Unsupported.
      case AddressFieldType.searchAddress:
      case AddressFieldType.selectAddress:
      case AddressFieldType.unknown:
      default:
        break;
    }
  }

  String? getFieldLabel(AddressFieldType type) {
    switch (type) {
      case AddressFieldType.firstName:
        return S.of(context).firstName;
      case AddressFieldType.lastName:
        return S.of(context).lastName;
      case AddressFieldType.phoneNumber:
        return S.of(context).phoneNumber;
      case AddressFieldType.email:
        return S.of(context).email;
      case AddressFieldType.country:
        return S.of(context).country;
      case AddressFieldType.state:
        return S.of(context).stateProvince;
      case AddressFieldType.city:
        return S.of(context).city;
      case AddressFieldType.apartment:
        return  S.of(context).streetNameApartment;
      case AddressFieldType.block:
        return S.of(context).streetNameBlock;
      case AddressFieldType.block2:
        return S.of(context).block2;
      case AddressFieldType.street:
        return S.of(context).street;
      case AddressFieldType.zipCode:
        return S.of(context).zipCode;
      case AddressFieldType.searchAddress:
      case AddressFieldType.selectAddress:
      default:
        return null;
    }
  }

  String? validateField(
      String? val, AddressFieldConfig config, AddressFieldType type) {
    if (!config.required) {
      return null;
    }

    final label = getFieldLabel(type)?.toLowerCase();
    if ((val?.isEmpty ?? true) && label != null) {
      return S.of(context).theFieldIsRequired(label);
    }
    if (val != null && type == AddressFieldType.email) {
      return validateEmail(val);
    }
    if (val != null && type == AddressFieldType.phoneNumber) {
      return validatePhoneNumber(val);
    }
    return null;
  }

  TextInputType getKeyboardType(AddressFieldType type) {
    if (type == AddressFieldType.zipCode &&
        kPaymentConfig.enableAlphanumericZipCode) {
      return TextInputType.streetAddress;
    }
    return type.keyboardType;
  }

  Widget _buildBottom() {
    return CommonSafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 150,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                if (!checkToSave()) return;
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Provider.of<CartModel>(context, listen: false)
                      .setAddress(address);
                  saveDataToLocal();
                } else {
                  FlashHelper.errorMessage(
                    context,
                    message: S.of(context).pleaseInput,
                  );
                }
              },
              icon: const Icon(
                CupertinoIcons.plus_app,
                size: 20,
              ),
              label: Text(
                S.of(context).saveAddress.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color:Theme.of(context).brightness == Brightness.dark? Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Container(width: 8),
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0.0,
                padding: const EdgeInsets.only(left: 8),
              ),
              icon:  Icon(
                Icons.local_shipping_outlined,
                size: 18,
                color: Theme.of(context).brightness == Brightness.dark?Colors.black:Colors.white,
              ),
              onPressed: _onNext,
              label: Text(
                (kPaymentConfig.enableShipping
                    ? S.of(context).continueToShipping
                    : kPaymentConfig.enableReview
                    ? S.of(context).continueToReview
                    : S.of(context).continueToPayment)
                    .toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).brightness == Brightness.dark?Colors.black:Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isFieldReadOnly(int index) {
    final config = _configs[index];
    if (config == null) {
      return false;
    }

    /// Disable edit only when the field has a default value.
    if (!config.editable && config.defaultValue.isNotEmpty) {
      return true;
    }

    return false;
  }
}