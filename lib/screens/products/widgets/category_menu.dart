import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../common/config.dart';
import '../../../generated/l10n.dart';
import '../../../models/index.dart';
import 'item_category.dart';

class ProductCategoryMenu extends StatefulWidget {
  final bool enableSearchHistory;
  final bool imageLayout;
  final String? newCategoryId;
  final Function(String?)? onTap;

  const ProductCategoryMenu({
    super.key,
    this.enableSearchHistory = false,
    this.imageLayout = false,
    this.newCategoryId,
    this.onTap,
  });

  @override
  StateProductCategoryMenu createState() => StateProductCategoryMenu();
}

class StateProductCategoryMenu extends State<ProductCategoryMenu> {
  bool get categoryImageMenu => kAdvanceConfig.categoryImageMenu;

  final itemScrollController = ItemScrollController();

  var firstJumpDone = false;

  String? parentOfSelectedCategoryId;

  void _animateToCategory(int index) {
    if (firstJumpDone) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (index > 3) {
        if (itemScrollController.isAttached) {
          itemScrollController.scrollTo(
            index: index - 1,
            duration: const Duration(milliseconds: 250),
          );
          firstJumpDone = true;
        }
      }
    });
  }

  Widget renderListCategories(List<Category> categories) {
    var categoryMenu = categoryImageMenu;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: Theme.of(context).colorScheme.background,
      constraints: const BoxConstraints(minHeight: 50),
      height: 130,
      child: Center(
        child: ScrollablePositionedList.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemScrollController: itemScrollController,
          itemBuilder: (context, index) {
            var category = categories[index];
            return ItemCategory(
              categoryId: category.id,
              categoryName: category.name!,
              categoryImage:
                  categoryMenu && widget.imageLayout ? category.image : null,
              newCategoryId: widget.newCategoryId,
              onTap: widget.onTap,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enableSearchHistory) {
      return const SizedBox(width: double.infinity);
    }

    return Consumer<CategoryModel>(builder: (context, categoryModel, child) {
      if (categoryModel.isLoading) {
        return Center(child: kLoadingWidget(context));
      }

      final categories = categoryModel.categories ?? <Category>[];

      var selectedCategoryId = widget.newCategoryId;

      final selectedCategory = categoryModel.categoryList[selectedCategoryId];

      if (selectedCategory == null) {
        return const SizedBox();
      }

      // if selected category has parent, don't need to check selected category is parent
      if (parentOfSelectedCategoryId == null) {
        final subCategoriesOfSelectedId =
            getSubCategories(categories, selectedCategoryId);

        // if selected category has sub categories, render selected category first
        // then render sub categories
        if (subCategoriesOfSelectedId.isNotEmpty) {
          subCategoriesOfSelectedId.insert(0, selectedCategory);
          final selectedIndex = subCategoriesOfSelectedId
              .indexWhere((o) => o.id == selectedCategoryId);
          _animateToCategory(selectedIndex);
          return renderListCategories(subCategoriesOfSelectedId);
        }
      }

      // if selected category has no sub categories, render all the categories
      // the same level
      // just find the parentOfSelectedCategory for first init
      if (parentOfSelectedCategoryId == null && firstJumpDone == false) {
        parentOfSelectedCategoryId =
            getParentCategories(categoryModel.categories, selectedCategoryId);
      }

      // if selected category has no parent, render all categories (Shopify case)
      if (parentOfSelectedCategoryId == null) {
        final selectedIndex =
            categories.indexWhere((o) => o.id == selectedCategoryId);
        _animateToCategory(selectedIndex);
        return renderListCategories(categories);
      }

      // =============================== //
      final parentCategoryOfSelectedCategory = categoryModel
          .categoryList[parentOfSelectedCategoryId.toString()]!
          .copyWith(name: S.of(context).seeAll);

      final listSubCategory =
          getSubCategories(categories, parentOfSelectedCategoryId);
      if (listSubCategory.length < 2) {
        return const SizedBox(width: double.infinity);
      }
      listSubCategory.insert(0, parentCategoryOfSelectedCategory);
      final selectedIndex =
          listSubCategory.indexWhere((o) => o.id == selectedCategoryId);
      _animateToCategory(selectedIndex);
      return renderListCategories(listSubCategory);
    });
  }

  String? getParentCategories(List<Category>? categories, id) {
    for (var item in (categories ?? <Category>[])) {
      if (item.id == id) {
        return (item.parent == null || item.isRoot) ? null : item.parent;
      }
    }
    return null;
  }

  List<Category> getSubCategories(List<Category> categories, String? id) {
    return categories.where((o) => o.parent == id).toList();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
