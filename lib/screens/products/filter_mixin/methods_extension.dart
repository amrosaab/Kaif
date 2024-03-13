part of 'products_filter_mixin.dart';

extension ProductsFilterMixinMethodExtension on ProductsFilterMixin {
  List<FilterAttribute> get listProductAttribute =>
      filterAttrModel.lstProductAttribute ?? <FilterAttribute>[];

  @protected
  void onFilter({
    dynamic minPrice,
    dynamic maxPrice,
    dynamic categoryId,
    String? categoryName,
    String? tagId,
    dynamic listingLocationId,
    FilterSortBy? sortBy,
    String? search,
    bool? isSearch,
  }) {
    printLog('[onFilter] ♻️ Reload product list');
    onCloseFilter();
    filterSortBy = sortBy ?? filterSortBy;

    if (listingLocationId != null) {
      this.listingLocationId = listingLocationId;
    }

    if (minPrice == maxPrice && minPrice == 0) {
      this.minPrice = null;
      this.maxPrice = null;
    } else {
      this.minPrice = minPrice ?? this.minPrice;
      this.maxPrice = maxPrice ?? this.maxPrice;
    }

    if (tagId != null) {
      this.tagId = tagId;
    }

    if (search != null) {
      this.search = search;
    }

    // set attribute
    if (filterAttrModel.selectedAttr != null &&
        filterAttrModel.indexSelectedAttr >= 0) {
      var selectedAttr =
          filterAttrModel.indexSelectedAttr < listProductAttribute.length
              ? listProductAttribute[filterAttrModel.indexSelectedAttr]
              : null;
      attribute = selectedAttr?.slug;
    }

    /// Set category title, ID
    if (categoryId != null) {
      this.categoryId = categoryId;

      final selectedCategoryName = categoryModel.categories
          ?.firstWhereOrNull((element) => element.id == categoryId.toString())
          ?.name;

      onCategorySelected(selectedCategoryName);
    }
    if (isSearch != null) {
      if (isSearch) {
        this.categoryId = kEmptyCategoryID;
      } else {
        this.search = null;
        onClearTextSearch();
      }
    }

    /// reset paging and clean up product
    page = 1;
    clearProductList();

    getProductList();
    rebuild();
  }

  Future<void> onLoadMore() async {
    page++;
    await getProductList();
  }

  @protected
  String getAttributeTerm({bool showName = false}) {
    var terms = '';

    for (var i = 0; i < filterAttrModel.lstCurrentSelectedTerms.length; i++) {
      if (filterAttrModel.lstCurrentSelectedTerms[i]) {
        if (showName) {
          terms += '${filterAttrModel.lstCurrentAttr[i].name},';
        } else {
          terms += '${filterAttrModel.lstCurrentAttr[i].id},';
        }
      }
    }

    return terms.isNotEmpty ? terms.substring(0, terms.length - 1) : '';
  }

  Future<void> onRefresh() async {
    page = 1;
    rebuild();
    await getProductList();
  }

  Future<void> initFilter({ProductConfig? config}) async {
    minPrice = null;
    maxPrice = null;
    page = 1;
    attribute = null;
    search = null;
    filterSortBy = const FilterSortBy();

    categoryId = config?.category;
    tagId = config?.tag;
    filterSortBy = filterSortBy
        .copyWith(
          onSale: config?.onSale,
          featured: config?.featured,
        )
        .copyWithString(
          orderBy: config?.orderby,
          order: config?.order,
        );
    listingLocationId = config?.jsonData?['location']?.toString();
    include = config?.include;

    var params = config?.advancedParams != null
        ? FilterProductParams.fromJson(config!.advancedParams!)
        : null;

    attribute = params?.attribute;
    var attributeTerm = params?.attributeTerm;

    for (var i = 0; i < listProductAttribute.length; i++) {
      if (listProductAttribute[i].slug == attribute) {
        await filterAttrModel.getAttr(
          id: listProductAttribute[i].id,
          attributeTerm: attributeTerm,
        );
        break;
      }
    }
  }

  @protected
  void resetFilter() {
    filterAttrModel.resetFilter();
  }

  @protected
  void resetPrice() {
    minPrice = 0.0;
    maxPrice = 0.0;
  }

  @protected
  void resetTag() {
    tagId = null;
  }
}
