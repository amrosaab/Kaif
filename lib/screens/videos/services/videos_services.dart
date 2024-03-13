import 'dart:convert' as convert;

import 'package:quiver/strings.dart';
import '../../../common/constants.dart';
import '../../../models/entities/product.dart';
import '../../../services/services.dart';
import '../models/vimeo_video_config.dart';

const int perPage = 10;

class VideoServices {
  int page = 1;
  bool hasNextPage = false;
  bool _isRequesting = false;

  Future<List<Product>> refreshItems(String langCode) async {
    if (!_isRequesting) {
      page = 1;
      return _getItems(page, langCode);
    } else {
      return <Product>[];
    }
  }

  Future<List<Product>> loadMoreItems(String langCode) async {
    if (hasNextPage && !_isRequesting) {
      page += 1;
      return _getItems(page, langCode);
    } else {
      return <Product>[];
    }
  }

  Future<List<Product>> _getItems(int page, String langCode) async {
    try {
      _isRequesting = true;
      var results = <Product>[];
      var products = await Services()
          .api
          .getVideoProducts(page: page, perPage: perPage, lang: langCode);
      _isRequesting = false;
      hasNextPage = products.length == perPage;
      for (var product in products) {
        if (product.mVideoUrl?.isNotEmpty ?? false) {
          results.add(product);
        }
      }
      return results;
    } catch (err) {
      _isRequesting = false;
      rethrow;
    }
  }

  Future<VimeoVideoConfig?> getVimeoVideoConfig({
    required String vimeoVideoId,
  }) async {
    try {
      final response = await httpGet(
        'https://player.vimeo.com/video/$vimeoVideoId/config'.toUri()!,
      );
      var body = convert.jsonDecode(response.body);
      if (body is Map && isNotBlank(body['message'])) {
        throw Exception(body['message']);
      } else {
        var vimeoVideo = VimeoVideoConfig.fromJson(body);
        return vimeoVideo;
      }
    } catch (e) {
      rethrow;
    }
  }
}
