import 'package:video_player/video_player.dart';

import '../../../models/entities/product.dart';

class Video {
  Video({this.product, this.videoUrl, this.videoPlayerController});

  Product? product;
  String? videoUrl;
  VideoPlayerController? videoPlayerController;
}
