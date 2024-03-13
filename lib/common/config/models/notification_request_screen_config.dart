class NotificationRequestScreenConfig {
  String? icon;
  String? title;
  String? image;
  String? desc;

  NotificationRequestScreenConfig({
    this.icon,
    this.title,
    this.image,
    this.desc,
  });

  NotificationRequestScreenConfig.fromJson(dynamic json) {
    icon = json['icon'];
    title = json['title'];
    image = json['image'];
    desc = json['desc'];
  }

  NotificationRequestScreenConfig copyWith({
    String? icon,
    String? title,
    String? image,
    String? desc,
  }) {
    return NotificationRequestScreenConfig(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      image: image ?? this.image,
      desc: desc ?? this.desc,
    );
  }

  Map toJson() {
    var map = <String, dynamic>{};
    map['icon'] = icon;
    map['title'] = title;
    map['image'] = image;
    map['desc'] = desc;
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
