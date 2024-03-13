import '../../entities/product.dart';
import '../../vendor/vendor_shipping_model.dart';
import 'cart_mixin.dart';

mixin VendorMixin on CartMixin {
  List<VendorShippingMethod> selectedShippingMethods = [];

  void setSelectedMethods(List<VendorShippingMethod> selected) {
    selectedShippingMethods = selected;
  }

  bool isDisableMultiVendorCheckoutValid(productsInCart, getProductById) {
    var isValid = true;
    var storeId;
    if (productsInCart.keys.isNotEmpty) {
      productsInCart.keys.forEach((key) {
        var id = Product.cleanProductID(key);
        final product = getProductById(id);
        if (storeId == null) {
          storeId = product?.store?.id;
        } else {
          if (storeId != product?.store?.id) {
            isValid = false;
          }
        }
      });
    }
    return isValid;
  }
}
