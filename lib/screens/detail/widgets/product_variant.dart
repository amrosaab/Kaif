import 'package:flutter/material.dart';
import 'package:inspireui/utils/logs.dart';
import 'package:provider/provider.dart';

import '../../../common/config.dart';
import '../../../common/tools/flash.dart';
import '../../../common/tools/tools.dart';
import '../../../generated/l10n.dart' show S;
import '../../../models/index.dart'
    show
        AddonsOption,
        AppModel,
        Product,
        ProductAttribute,
        ProductModel,
        ProductVariation;
import '../../../models/product_variant_model.dart';
import '../../../services/index.dart';
import '../../../widgets/common/webview.dart';
import 'buy_button_widget.dart';

class ProductVariant extends StatefulWidget {
  final Product? product;
  final Function? onSelectVariantImage;
  final int defaultQuantity;
  final bool isModal;

  const ProductVariant(
    this.product, {
    this.onSelectVariantImage,
    this.defaultQuantity = 1,
    this.isModal = false,
  });

  @override
  // ignore: no_logic_in_create_state
  State<ProductVariant> createState() => _StateProductVariant(product!);
}

class _StateProductVariant extends State<ProductVariant> {
  Product product;

  ProductVariantModel get model =>
      Provider.of<ProductVariantModel>(context, listen: false);

  ProductVariation? get productVariation => model.productVariation;
  Map<String, Map<String, AddonsOption>> get selectedOptions =>
      model.selectedOptions;
  Map<String?, String?>? get mapAttribute => model.mapAttribute;
  int get quantity => model.quantity;

  _StateProductVariant(this.product);

  final services = Services();

  List<ProductVariation>? get variations =>
      context.select((ProductModel _) => _.variations);

  void updateSelectedOptions(
      Map<String, Map<String, AddonsOption>> selectedOptions) {
    model.updateValues(selectedOptions: selectedOptions);
    final options = <AddonsOption>[];
    for (var addOns in selectedOptions.values) {
      options.addAll(addOns.values);
    }
    product.selectedOptions = options;
  }

  /// Get product variants
  Future<void> getProductVariations() async {
    await services.widget.getProductVariations(
        context: context,
        product: product,
        onLoad: ({
          Product? productInfo,
          List<ProductVariation>? variations,
          Map<String?, String?>? mapAttribute,
          ProductVariation? variation,
        }) {
          if (productInfo != null) {
            product = productInfo;
            model.initWithProduct(productInfo);
          }
          model.updateValues(mapAttribute: mapAttribute ?? {});
          if (variations != null) {
            context.read<ProductModel>().changeProductVariations(
                  variations,
                  notify: false,
                );
            model.updateValues(productVariation: variation);
            context
                .read<ProductModel>()
                .changeSelectedVariation(productVariation);
          }
          if (!mounted) {
            return;
          }
          setState(() {});
        });
  }

  Future<void> getProductAddons() async {
    await services.widget.getProductAddons(
      context: context,
      product: product,
      selectedOptions: selectedOptions,
      onLoad: (
          {Product? productInfo,
          required Map<String, Map<String, AddonsOption>> selectedOptions}) {
        if (productInfo != null) {
          product = productInfo;
        }
        updateSelectedOptions(selectedOptions);
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    product = widget.product as Product;
    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) {
          model.updateValues(quantity: widget.defaultQuantity);
          getProductVariations();
          getProductAddons();
        }
      },
    );
  }

  @override
  void dispose() {
    FlashHelper.dispose();
    Services().iapDispose();
    super.dispose();
  }

  /// Support Affiliate product
  Future<void> openExternal() async {
    final url = Tools.prepareURL(product.affiliateUrl);
    if (url != null) {
      try {
        if (Tools.needToOpenExternalApp(url)) {
          await Tools.launchURL(url);
        } else {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebView(
                url: product.affiliateUrl,
                title: product.name,
              ),
            ),
          );
        }
        return;
      } catch (e) {
        printError(e);
      }
    }
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Center(
          child: Text(S.of(context).notFound),
        ),
      );
    }));
  }

  void onSelectProductVariant({
    ProductAttribute? attr,
    String? val,
    List<ProductVariation>? variations,
    Map<String?, String?>? mapAttribute,
    Function? onFinish,
  }) {
    services.widget.onSelectProductVariant(
      attr: attr!,
      val: val,
      variations: variations!,
      mapAttribute: mapAttribute!,
      onFinish:
          (Map<String?, String?> mapAttribute, ProductVariation? variation) {
        model.updateValues(
            mapAttribute: mapAttribute,
            productVariation: variation,
            quantity: 1);
        context.read<ProductModel>().changeSelectedVariation(variation);

        /// Show selected product variation image in gallery.
        final attrType = kProductVariantLayout[attr.cleanSlug ?? attr.name] ??
            kProductVariantLayout[attr.name!.toLowerCase()] ??
            'box';
        if (widget.onSelectVariantImage != null && attrType == 'image') {
          for (var option in attr.options!) {
            if (option['name'] == val &&
                option['description'].toString().contains('http')) {
              final selectedImageUrl = option['description'];
              widget.onSelectVariantImage!(selectedImageUrl);
            }
          }
        }
      },
    );
  }

  void onSelectProductAddons({
    required Map<String, Map<String, AddonsOption>> selectedOptions,
  }) {
    setState(() {
      updateSelectedOptions(selectedOptions);
    });
  }

  List<Widget> getProductAttributeWidget() {
    final lang = Provider.of<AppModel>(context, listen: false).langCode;
    if (mapAttribute == null && ServerConfig().type != ConfigType.opencart) {
      return [];
    }
    return services.widget.getProductAttributeWidget(
        lang, product, mapAttribute, onSelectProductVariant, variations!);
  }

  List<Widget> getProductAddonsWidget() {
    final lang = Provider.of<AppModel>(context, listen: false).langCode;
    return services.widget.getProductAddonsWidget(
      context: context,
      selectedOptions: selectedOptions,
      lang: lang,
      product: product,
      onSelectProductAddons: onSelectProductAddons,
      quantity: quantity,
    );
  }

  List<Widget> getProductTitleWidget() {
    return services.widget
        .getProductTitleWidget(context, productVariation, product);
  }

  @override
  Widget build(BuildContext context) {
    FlashHelper.init(context);
    final isVariationLoading = productVariation == null &&
        (variations?.isEmpty ?? true) &&
        ServerConfig().type != ConfigType.opencart &&
        ServerConfig().type != ConfigType.notion;
    var layoutType = Provider.of<AppModel>(context).productDetailLayout;

    return Column(
      children: <Widget>[
        ...getProductTitleWidget(),
        if (!isVariationLoading) ...getProductAttributeWidget(),
        ...getProductAddonsWidget(),
        if (!kProductDetail.fixedBuyButtonToBottom ||
            ['halfSizeImageType', 'fullSizeImageType'].contains(layoutType) ||
            widget.isModal)
          const BuyButtonWidget(),
      ],
    );
  }
}
