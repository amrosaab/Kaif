part of '../../boxes.dart';

extension AddressCommerceSettingsExtension on AddressBox {
  Address? getShippingAddress(String isoCode) {
    final rawData = box.get(
      isoCode,
      defaultValue: null,
    );
    return rawData != null ? Address.fromLocalJson(rawData) : null;

  }

  void setShippingAddress(Address? value, String isoCode) {
    if (value == null) {
      box.delete(isoCode);
      return;
    }
    final rawData = value.toJson();
    box.put(isoCode, rawData);
  }

  List<Address> get addresses {
    final rawData = box.values;
    final listAddress = <Address>[];
    // print("dfsdfsd");

    // if (rawData is List) {
    for (var item in rawData) {
      Address? address;

      try {
        address = Address.fromLocalJson(item);
      } catch (err, trace) {
        printError(err, trace);
      }

      if (address != null) {
        listAddress.add(address);
      }
    }
    //  }

    return listAddress;
  }

  set addresses(List<Address>? value)  {
    // if (value == null) {
    //   box.clear();
    //   return;
    // }
    //
    //
    // final rawData = value.map((e) => e.toJsonEncodable()).toList();
    // print("dsfdsfds${value}");
    // box.addAll(rawData);

    this.addresses=addresses;




  }

  removeAdresses(Address value) async {

    if (value == null) {
      box.clear();
      return;
    }


    // final rawData = value.map((e) => e.toJsonEncodable()).toList();
    // print("dsfdsfds${value}");
    // await box.clear();

    await box.delete(value.country);
  }



}
