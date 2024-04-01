part of '../boxes.dart';

/// Enable encryption for user-related data.
class AddressBox extends FluxBox with EncryptionMixin {
  static final _instance = AddressBox._internal();

  factory AddressBox() => _instance;

  AddressBox._internal();

  @override
  String get boxKey => BoxKeys.hiveAddressBox;

  @override
  String get encryptionKeyName => BoxKeys.hiveUserBoxEncryptionKey;
}

extension AddressBoxExtension on AddressBox {
  /// Call this upon logout to clear all user data.
  void cleanUpForLogout() {
    box.clear();
  }
}
