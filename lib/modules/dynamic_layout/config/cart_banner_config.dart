/// Show: false
/// imageUrl: 'https://picsum.photos/600/300'
/// delayInMilliseconds: 0
/// durationInMilliseconds: 0
/// borderRadius: 0.0
/// destination: null

class CartBannerConfig {
  final bool show;
  final String imageUrl;
  final int delayInMilliseconds;
  final int durationInMilliseconds;
  final double borderRadius;
  final String? destination;
  final dynamic jsonData;

  CartBannerConfig({
    required this.show,
    required this.imageUrl,
    required this.delayInMilliseconds,
    required this.durationInMilliseconds,
    required this.borderRadius,
    this.destination,
    this.jsonData,
  });

  factory CartBannerConfig.fromJson(Map<String, dynamic> json) {
    return CartBannerConfig(
      show: json['show'] ?? false,
      imageUrl: json['imageUrl'] ?? 'https://picsum.photos/600/300',
      delayInMilliseconds: json['delayInMilliseconds'] ?? 0,
      durationInMilliseconds: json['durationInMilliseconds'] ?? 0,
      borderRadius: json['borderRadius'] != null
          ? double.tryParse(json['borderRadius'].toString()) ?? 0.0
          : 0.0,
      destination: json['destination'],
      jsonData: json,
    );
  }

  Map<String, dynamic> toJson() => {
        'show': show,
        'imageUrl': imageUrl,
        'delayInMilliseconds': delayInMilliseconds,
        'durationInMilliseconds': durationInMilliseconds,
        'borderRadius': borderRadius,
        'destination': destination,
      };
}
