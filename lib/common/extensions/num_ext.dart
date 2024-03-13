extension DoubleNullSafety on double? {
  bool get isNotNullAndNotZero => this != null && this != 0;
  bool get isNullOrZero => this == null || this == 0;
}

extension IntNullSafety on int? {
  bool get isNotNullAndNotZero => this != null && this != 0;
  bool get isNullOrZero => this == null || this == 0;
}
