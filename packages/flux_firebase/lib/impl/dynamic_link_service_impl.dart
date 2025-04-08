import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:fstore/common/config.dart';
import 'package:fstore/common/constants.dart' show RouteList;
import 'package:fstore/generated/l10n.dart';
import 'package:fstore/models/entities/back_drop_arguments.dart';
import 'package:fstore/models/entities/store_arguments.dart';
import 'package:fstore/routes/flux_navigate.dart';
import 'package:fstore/screens/blog/views/blog_detail_screen.dart';
import 'package:fstore/services/firebase/dynamic_link_service.dart';
import 'package:fstore/services/service_config.dart';
import 'package:fstore/services/services.dart';
import 'package:fstore/widgets/common/webview.dart';
import 'package:share/share.dart';

final _appLinks = AppLinks();

class DynamicLinkServiceImpl extends DynamicLinkService {
  final _service = Services();

  Future<void> initUniLinks(context) async {
    // Subscribe to all events when app is started.
// (Use allStringLinkStream to get it as [String])
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
    //  await handleDynamicLink(initialLink, context);
    }

    _appLinks.uriLinkStream.listen((uri) async {
      if(uri.toString().contains("request_ip_version")){
        return;

      }
      await handleDynamicLink(uri, context);

      // Do something (navigation, ...)
    });
  }

  @override
  void initDynamicLinks(BuildContext context) async {
    await initUniLinks(context);

    // var initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

    // if (initialLink != null) {
    //   final deepLink = initialLink.link;
    //   printLog('[firebase-dynamic-link] getInitialLink: $deepLink');
    //   await handleDynamicLink(deepLink.toString(), context);
    // }

    // FirebaseDynamicLinks.instance.onLink.listen((event) {});
    // FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    //   handleDynamicLink(dynamicLinkData.link.path, context);
    // }).onError((e) {
    //   printLog('[firebase-dynamic-link] error: ${e.message}');
    // });
  }

  /// share product link that contains Dynamic link
  @override
  void shareProductLink({
    required String productUrl,
  }) async {
    /// TODO(fahjan): send direct url without firebase,
    /// we don't use fire base, so we install
    /// app_links library instead

    await Share.share(
      productUrl,
    );
    return;
    // print('productUrl: $productUrl');
    // var productParams = dynamicLinkParameters(url: productUrl);
    // var firebaseDynamicLink = await generateFirebaseDynamicLink(productParams);

    // printLog('[firebase-dynamic-link] $firebaseDynamicLink');
    // await Share.share(
    //   firebaseDynamicLink.toString(),
    // );
  }

  @override
  Future<String> generateProductCategoryUrl(dynamic productCategoryId) async {
    final cate = await _service.api
        .getCategories();
    // final cate = await _service.api
    //    .getProductCategoryById(categoryId: productCategoryId);
    //
    print("xzcxzc${productCategoryId!}");
    productCategoryId=productCategoryId;
    var url;
    if (cate != null) {
      if (ServerConfig().isShopify) {
        url = cate.firstWhere((element) => element.id==productCategoryId).onlineStoreUrl;
      } else {
        url = '${ServerConfig().url}/product-category/${cate.firstWhere((element) => element.id==productCategoryId).slug}';
      }
    }
    return url;
  }

  @override
  Future<String> generateProductTagUrl(dynamic productTagId) async {
    final tag = await _service.api.getTagById(tagId: productTagId.toString());
    var url;
    if (tag != null) {
      url = '${ServerConfig().url}/product-tag/${tag.slug}';
    }
    return url;
  }

  @override
  Future<String> generateProductBrandUrl(dynamic brandCategoryId) async {
    final brand = await _service.api.getBrandById(brandCategoryId);
    var url;
    if (brand != null) {
      url = serverConfig['url'] + '/brand/' + brand.slug;
    }
    return url;
  }

  //Navigate to ProductDetail screen by entering productURL
  @override
  Future<void> handleDynamicLink(Uri uri, BuildContext context) async {
    try {
      _showLoading(context);
      var url = Uri.parse(uri.path).toString();

      /// PRODUCT CASE
      if (url.contains('/product/') ||
          url.contains('/shop/') ||
          url.contains('/products/')) {
        /// Note: the deepLink URL will look like: https://mstore.io/product/stitch-detail-tunic-dress/
        final product = await Services().api.getProductByPermalink(url);
        if (product != null) {
          await FluxNavigate.pushNamed(
            RouteList.productDetail,
            arguments: product,
          );
        }

        /// PRODUCT CATEGORY CASE
      } else if (url.contains('/product-category/') ||
          url.contains('/collections/')) {
        final category =
            await Services().api.getProductCategoryByPermalink(url);
        if (category != null) {
          await FluxNavigate.pushNamed(
            RouteList.backdrop,
            arguments: BackDropArguments(
              cateId: category.id,
              cateName: category.name,
            ),
          );
        }

        /// PRODUCT TAGS CASE
      } else if (url.contains('/product-tag/')) {
        final slug = Uri.tryParse(url)?.pathSegments.last;

        if (slug == null) throw '';

        final tag = await Services().api.getTagBySlug(slug);
        if (tag != null) {
          await FluxNavigate.pushNamed(
            RouteList.backdrop,
            arguments: BackDropArguments(
              tag: tag.id.toString(),
            ),
          );
        }

        /// VENDOR CASE
      } else if (url.contains('/store/')) {
        final vendor = await Services().api.getStoreByPermalink(url);
        if (vendor != null) {
          await FluxNavigate.pushNamed(
            RouteList.storeDetail,
            arguments: StoreDetailArgument(store: vendor),
          );
        }
      } else if (url.contains('/brand/')) {
        final slug = Uri.tryParse(url)?.pathSegments.last;

        if (slug == null) throw '';

        final brand = await Services().api.getBrandBySlug(slug);
        if (brand != null) {
          await FluxNavigate.pushNamed(
            RouteList.backdrop,
            arguments: BackDropArguments(
              brandId: brand.id,
              brandName: brand.name,
              brandImg: brand.image,
            ),
          );
        }
      } else if (url.contains('/listing/')) {
        var blog = await Services().api.getBlogByPermalink(url);
        var product = await Services().api.getProduct(blog?.id);
        if (product != null) {
          await FluxNavigate.pushNamed(
            RouteList.productDetail,
            arguments: product,
          );
        }
      } else {
        var blog = await Services().api.getBlogByPermalink(url);
        if (blog != null) {
          await FluxNavigate.pushNamed(
            RouteList.detailBlog,
            arguments: BlogDetailArguments(blog: blog),
          );
        }
        else {
          await  Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebView(
                enableBackward: false,
                enableForward: false,
                url: uri.toString(),
              ),
            ),
          );
        }
      }
    } catch (err) {
      _showErrorMessage(context);
    }
  }

  DynamicLinkParameters dynamicLinkParameters({required String url}) {
    // use full url to open it into website with users whom nit installed application
    return DynamicLinkParameters(
      uriPrefix: url, //firebaseDynamicLinkConfig['uriPrefix'],
      link: Uri.parse(url),
      androidParameters: AndroidParameters(
        packageName: firebaseDynamicLinkConfig['androidPackageName'],
        minimumVersion: firebaseDynamicLinkConfig['androidAppMinimumVersion'],
      ),
      iosParameters: IOSParameters(
        bundleId: firebaseDynamicLinkConfig['iOSBundleId'],
        minimumVersion: firebaseDynamicLinkConfig['iOSAppMinimumVersion'],
        appStoreId: firebaseDynamicLinkConfig['iOSAppStoreId'],
      ),
    );
  }

  Future<Uri> generateFirebaseDynamicLink(DynamicLinkParameters params) async {
    var dynamicLinks = FirebaseDynamicLinks.instance;

    if (firebaseDynamicLinkConfig['shortDynamicLinkEnable'] ?? false) {
      var shortDynamicLink = await dynamicLinks.buildShortLink(params);
      return shortDynamicLink.shortUrl;
    } else {
      return await dynamicLinks.buildLink(params);
    }
  }

  static void _showLoading(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.current.loadingLink),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void _showErrorMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.current.canNotLoadThisLink),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}


/* import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:fstore/common/config.dart';
import 'package:fstore/common/constants.dart'
    show RouteList, isAndroid, printLog;
import 'package:fstore/generated/l10n.dart';
import 'package:fstore/models/entities/back_drop_arguments.dart';
import 'package:fstore/models/entities/store_arguments.dart';
import 'package:fstore/routes/flux_navigate.dart';
import 'package:fstore/screens/blog/views/blog_detail_screen.dart';
import 'package:fstore/services/firebase/dynamic_link_service.dart';
import 'package:fstore/services/index.dart';
import 'package:share/share.dart';

class DynamicLinkServiceImpl extends DynamicLinkService {
  final _service = Services();

  @override
  void initDynamicLinks(BuildContext context) async {
    
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      handleDynamicLink(dynamicLinkData.link.path, context);
    }).onError((e) {
      printLog('[firebase-dynamic-link] error: ${e.message}');
    });

    // If run below code on ios, the app will open dynamic link twice
    if (isAndroid) {
      var initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
      if (initialLink != null) {
        final deepLink = initialLink.link;
        printLog('[firebase-dynamic-link] getInitialLink: $deepLink');
        await handleDynamicLink(deepLink.toString(), context);
      }
    }
  }

  /// share product link that contains Dynamic link
  @override
  void shareProductLink({
    required String productUrl,
  }) async {
    var productParams = dynamicLinkParameters(url: productUrl);
    var firebaseDynamicLink = await generateFirebaseDynamicLink(productParams);
    printLog('[firebase-dynamic-link] $firebaseDynamicLink');
    await Share.share(
      firebaseDynamicLink.toString(),
    );
  }

  @override
  Future<String?> generateProductCategoryUrl(dynamic productCategoryId) async {
    final cate = await _service.api
        .getProductCategoryById(categoryId: productCategoryId);
    var url;
    if (cate != null) {
      if (ServerConfig().isShopify) {
        url = cate.onlineStoreUrl;
      } else {
        url = '${ServerConfig().url}/product-category/${cate.slug}';
      }
    }
    return url;
  }

  @override
  Future<String?> generateProductTagUrl(dynamic productTagId) async {
    final tag = await _service.api.getTagById(tagId: productTagId.toString());
    var url;
    if (tag != null) {
      url = '${ServerConfig().url}/product-tag/${tag.slug}';
    }
    return url;
  }

  @override
  Future<String?> generateProductBrandUrl(dynamic brandCategoryId) async {
    final brand = await _service.api.getBrandById(brandCategoryId);
    var url;
    if (brand != null) {
      url = serverConfig['url'] + '/brand/' + brand.slug;
    }
    return url;
  }

  //Navigate to ProductDetail screen by entering productURL
  @override
  Future<void> handleDynamicLink(String url, BuildContext context) async {
    try {
      _showLoading(context);

      if (url.contains('page.link')) {
        url = await _unShortenUrl(url) ?? url;
      }

      /// PRODUCT CASE
      if (url.contains('/product/') ||
          url.contains('/shop/') ||
          url.contains('/products/')) {
        /// Note: the deepLink URL will look like: https://mstore.io/product/stitch-detail-tunic-dress/
        final product = await Services().api.getProductByPermalink(url);
        if (product != null) {
          await FluxNavigate.pushNamed(
            RouteList.productDetail,
            arguments: product,
          );
        }

        /// PRODUCT CATEGORY CASE
      } else if (url.contains('/product-category/') ||
          url.contains('/collections/')) {
        final category =
            await Services().api.getProductCategoryByPermalink(url);
        if (category != null) {
          await FluxNavigate.pushNamed(
            RouteList.backdrop,
            arguments: BackDropArguments(
              cateId: category.id,
              cateName: category.name,
            ),
          );
        }

        /// PRODUCT TAGS CASE
      } else if (url.contains('/product-tag/')) {
        final slug = Uri.tryParse(url)?.pathSegments.last;

        if (slug == null) throw '';

        final tag = await Services().api.getTagBySlug(slug);
        if (tag != null) {
          await FluxNavigate.pushNamed(
            RouteList.backdrop,
            arguments: BackDropArguments(
              tag: tag.id.toString(),
            ),
          );
        }

        /// VENDOR CASE
      } else if (url.contains('/store/')) {
        final vendor = await Services().api.getStoreByPermalink(url);
        if (vendor != null) {
          await FluxNavigate.pushNamed(
            RouteList.storeDetail,
            arguments: StoreDetailArgument(store: vendor),
          );
        }
      } else if (url.contains('/brand/')) {
        final slug = Uri.tryParse(url)?.pathSegments.last;

        if (slug == null) throw '';

        final brand = await Services().api.getBrandBySlug(slug);
        if (brand != null) {
          await FluxNavigate.pushNamed(
            RouteList.backdrop,
            arguments: BackDropArguments(
              brandId: brand.id,
              brandName: brand.name,
              brandImg: brand.image,
            ),
          );
        }
      } else if (url.contains('/listing/')) {
        var blog = await Services().api.getBlogByPermalink(url);
        var product = await Services().api.getProduct(blog?.id);
        if (product != null) {
          await FluxNavigate.pushNamed(
            RouteList.productDetail,
            arguments: product,
          );
        }
      } else {
        var blog = await Services().api.getBlogByPermalink(url);
        if (blog != null) {
          await FluxNavigate.pushNamed(
            RouteList.detailBlog,
            arguments: BlogDetailArguments(blog: blog),
          );
        }
      }
    } catch (err) {
      _showErrorMessage(context);
    }
  }

  DynamicLinkParameters dynamicLinkParameters({required String url}) {
    return DynamicLinkParameters(
      uriPrefix: firebaseDynamicLinkConfig['uriPrefix'],
      link: Uri.parse(url),
      androidParameters: AndroidParameters(
        packageName: firebaseDynamicLinkConfig['androidPackageName'],
        minimumVersion: firebaseDynamicLinkConfig['androidAppMinimumVersion'],
      ),
      iosParameters: IOSParameters(
        bundleId: firebaseDynamicLinkConfig['iOSBundleId'],
        minimumVersion: firebaseDynamicLinkConfig['iOSAppMinimumVersion'],
        appStoreId: firebaseDynamicLinkConfig['iOSAppStoreId'],
      ),
    );
  }

  Future<Uri> generateFirebaseDynamicLink(DynamicLinkParameters params) async {
    var dynamicLinks = FirebaseDynamicLinks.instance;

    if (firebaseDynamicLinkConfig['shortDynamicLinkEnable'] ?? false) {
      var shortDynamicLink = await dynamicLinks.buildShortLink(params);
      return shortDynamicLink.shortUrl;
    } else {
      return await dynamicLinks.buildLink(params);
    }
  }

  static void _showLoading(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.current.loadingLink),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void _showErrorMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.current.canNotLoadThisLink),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<String?> _unShortenUrl(String url) async {
    final uri = Uri.parse(url);
    final unShortenUrl =
        await FirebaseDynamicLinks.instance.getDynamicLink(uri);
    return unShortenUrl?.link.toString();
  }
}
 */