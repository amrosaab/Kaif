class VersionCheckConfig {
  final bool enable;
  final String? iosId;
  final String? iOSAppStoreCountry;
  final String? androidId;
  final String? androidPlayStoreCountry;

  const VersionCheckConfig({
    required this.enable,
    this.iosId,
    this.iOSAppStoreCountry,
    this.androidId,
    this.androidPlayStoreCountry,
  });

  factory VersionCheckConfig.fromJson(Map<String, dynamic> json) {
    return VersionCheckConfig(
      enable: json['enable'] ?? false,
      iosId: json['iosId']?.toString(),
      iOSAppStoreCountry: json['iOSAppStoreCountry']?.toString().toUpperCase(),
      androidId: json['androidId']?.toString(),
      androidPlayStoreCountry:
      json['androidPlayStoreCountry']?.toString().toUpperCase(),
    );
  }

  Map<String, dynamic> toJson() {
    var config = {
      'enable': enable,
      'iosId': iosId,
      'iOSAppStoreCountry': iOSAppStoreCountry,
      'androidId': androidId,
      'androidPlayStoreCountry': androidPlayStoreCountry,
    };
    config.removeWhere((key, value) => (value == null || value == ''));
    return config;
  }

  VersionCheckConfig copyWith({
    bool? enable,
    String? iosId,
    String? iOSAppStoreCountry,
    String? androidId,
    String? androidPlayStoreCountry,
  }) {
    return VersionCheckConfig(
      enable: enable ?? this.enable,
      iosId: iosId ?? this.iosId,
      iOSAppStoreCountry: iOSAppStoreCountry ?? this.iOSAppStoreCountry,
      androidId: androidId ?? this.androidId,
      androidPlayStoreCountry:
      androidPlayStoreCountry ?? this.androidPlayStoreCountry,
    );
  }
}