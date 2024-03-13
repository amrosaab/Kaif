import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:inspireui/widgets/skeleton_widget/skeleton_widget.dart';
import 'package:provider/provider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../common/config.dart';
import '../../../generated/l10n.dart';
import '../../../models/category/category_model.dart';
import '../../../models/category/detail_category_model.dart';
import '../../../models/category/list_category_model.dart';
import '../../../models/category/list_product_model.dart';
import '../../../models/entities/category.dart';
import '../../../modules/dynamic_layout/config/index.dart';
import '../../../widgets/product/product_card_view.dart';
import '../widgets/list_product.dart';

const _numberOfTabPreload = 3;

class FancyScrollCategories extends StatefulWidget {
  const FancyScrollCategories({Key? key}) : super(key: key);

  /// Only work for enableLargeCategory
  static const type = 'fancy-scroll';

  @override
  State<FancyScrollCategories> createState() => _FancyScrollCategoriesState();
}

class _FancyScrollCategoriesState extends State<FancyScrollCategories>
    with SingleTickerProviderStateMixin {
  CategoryModel get model => Provider.of<CategoryModel>(context, listen: false);

  TabController? _tabController;

  void _onChanged([int? index]) {
    final data = model.categories;
    if (data == null) return;
    final selectedIndex = index ?? _tabController?.index;
    if (selectedIndex == null) return;
    final element = data[selectedIndex];
    model.getDetailCategoryModel(element.id!)?.initData();
  }

  @override
  void dispose() {
    _tabController?.removeListener(_onChanged);
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryModel>(
      builder: (context, model, child) {
        if (model.isFirstLoad) {
          return Center(child: kLoadingWidget(context));
        }
        if (model.categories!.isEmpty) {
          return Center(child: Text(S.of(context).noData));
        }
        final data = model.categories!;
        for (var i = 0; i < data.length; i++) {
          final element = data[i];
          model.initSubcategory(element,
              fetchData: i <
                  math.min(
                    data.length,
                    _numberOfTabPreload,
                  ));
        }
        _tabController ??= TabController(
          length: data.length,
          vsync: this,
        )..addListener(_onChanged);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 50,
              color: Theme.of(context).primaryColor,
              child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  onTap: _onChanged,
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  indicatorPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  indicatorColor: Theme.of(context).colorScheme.secondary,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: data
                      .map((e) => Tab(
                            text: e.displayName.toUpperCase(),
                          ))
                      .toList()),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: data.map(
                  (e) {
                    final detailCategoryModel =
                        model.getDetailCategoryModel(e.id!);
                    if (detailCategoryModel == null) {
                      return const SizedBox();
                    }
                    return ChangeNotifierProvider.value(
                      value: detailCategoryModel,
                      child: Selector<DetailCategoryModel, bool?>(
                        shouldRebuild: (previous, next) {
                          return previous != next;
                        },
                        selector: (context, provider) => provider.hasChildren,
                        builder: (context, hasChildren, child) {
                          if (hasChildren == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (hasChildren) {
                            return ChangeNotifierProvider.value(
                              value: detailCategoryModel.subcategoryModel,
                              child: const SyncTabBarWithListView(),
                            );
                          }
                          return ChangeNotifierProvider.value(
                            value: detailCategoryModel.listProductModel,
                            child: const ListProduct(),
                          );
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SyncTabBarWithListView extends StatefulWidget {
  const SyncTabBarWithListView({
    Key? key,
  }) : super(key: key);

  @override
  State<SyncTabBarWithListView> createState() => _SyncTabBarWithListViewState();
}

class _SyncTabBarWithListViewState extends State<SyncTabBarWithListView>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<SyncTabBarWithListView> {
  TabController? _tabController;
  late final AutoScrollController _scrollController;

  final _cache = <int, ListProductModel>{};

  final listViewKey = RectGetter.createGlobalKey();
  final Map<int, dynamic> itemKeys = {};

  List<Category> get categories => Provider.of<ListCategoryModel>(context).data;

  bool isCollapsed = false;

  // prevent animate when press on tab bar
  bool pauseRectGetterIndex = false;

  bool onScrollNotification(ScrollNotification notification) {
    final tabController = _tabController;
    if (tabController == null) return false;

    if (pauseRectGetterIndex) return false;
    final lastTabIndex = tabController.length - 1;
    final visibleItems = getVisibleItemsIndex();

    final reachLastTabIndex =
        visibleItems.length <= 2 && visibleItems.last == lastTabIndex;
    if (reachLastTabIndex) {
      tabController.animateTo(lastTabIndex);
    } else {
      var sumIndex = visibleItems.reduce((value, element) => value + element);
      var middleIndex = sumIndex ~/ visibleItems.length;
      if (tabController.index != middleIndex) {
        tabController.animateTo(middleIndex);
      }
    }

    return false;
  }

  List<int> getVisibleItemsIndex() {
    final rect = RectGetter.getRectFromKey(listViewKey);
    var items = <int>[];
    if (rect == null) return items;
    itemKeys.forEach((index, key) {
      final itemRect = RectGetter.getRectFromKey(key);
      if (itemRect == null) return;
      if (itemRect.top > rect.bottom) return;
      if (itemRect.bottom < rect.top) return;
      items.add(index);
    });
    return items;
  }

  void animateAndScrollTo(int index) {
    pauseRectGetterIndex = true;
    _tabController?.animateTo(index);
    _scrollController
        .scrollToIndex(index, preferPosition: AutoScrollPosition.begin)
        .then((value) => pauseRectGetterIndex = false);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = AutoScrollController();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController.dispose();
    for (final item in _cache.entries) {
      item.value.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ListCategoryModel>(
      builder: (context, provider, child) {
        final categories = provider.data;
        if (categories.isNotEmpty) {
          _tabController ??= TabController(
            length: categories.length,
            vsync: this,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 0.2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: provider.isFirstLoad
                  ? const _TabBarSkeleton()
                  : TabBar(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                      indicator: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 0.5,
                        ),
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      unselectedLabelColor: Theme.of(context).primaryColor,
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      indicatorPadding: const EdgeInsets.symmetric(
                        horizontal: 2,
                      ),
                      isScrollable: true,
                      controller: _tabController,
                      labelPadding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      onTap: (index) => animateAndScrollTo(index),
                      tabs: categories
                          .map(
                            (e) => Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(e.displayName),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
            Expanded(
              child: provider.isFirstLoad
                  ? const _ListViewSkeleton()
                  : RectGetter(
                      key: listViewKey,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: onScrollNotification,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: categories.length,
                          cacheExtent: 1000,
                          itemBuilder: (context, index) {
                            final productModel = _cache.putIfAbsent(
                              index,
                              () => ListProductModel(
                                categoryId: categories[index].id!,
                                limit: 12,
                              )..getData(),
                            );
                            return RectGetter(
                              key: itemKeys.putIfAbsent(
                                index,
                                () => RectGetter.createGlobalKey(),
                              ),
                              child: AutoScrollTag(
                                key: ValueKey(index),
                                index: index,
                                controller: _scrollController,
                                child: AnimatedBuilder(
                                  animation: productModel,
                                  builder: (context, child) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          color: Theme.of(context)
                                              .disabledColor
                                              .withOpacity(0.1),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 16,
                                          ),
                                          child: Text(
                                            categories[index].displayName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        if (productModel.isFirstLoad)
                                          const _GridViewSkeleton()
                                        else
                                          GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 0.45,
                                              crossAxisSpacing: 6,
                                              mainAxisSpacing: 6,
                                            ),
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 12,
                                            ),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: productModel.data.length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  productModel.data[index];
                                              return LayoutBuilder(builder:
                                                  (context, constraints) {
                                                return ProductCard(
                                                  item: item,
                                                  width: constraints.maxWidth,
                                                  maxWidth:
                                                      constraints.maxWidth,
                                                  config: ProductConfig.empty()
                                                    ..showCartButtonWithQuantity =
                                                        true
                                                    ..showCartIcon = false
                                                    ..hPadding = 0
                                                    ..vPadding = 0
                                                    ..vMargin = 0
                                                    ..hMargin = 0
                                                    ..imageRatio = 1.3,
                                                );
                                              });
                                            },
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _TabBarSkeleton extends StatelessWidget {
  const _TabBarSkeleton();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: TabBar(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        indicator: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 0.5,
          ),
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
        ),
        unselectedLabelColor: Theme.of(context).primaryColor,
        labelStyle: const TextStyle(
          fontSize: 15,
        ),
        indicatorPadding: const EdgeInsets.symmetric(
          horizontal: 2,
        ),
        isScrollable: true,
        labelPadding: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        tabs: List.generate(
          5,
          (index) => Tab(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 0.3,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Skeleton(
                  width: 80,
                  height: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ListViewSkeleton extends StatelessWidget {
  const _ListViewSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).disabledColor.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: const Row(
              children: [
                SizedBox(width: 10),
                Skeleton(
                  width: 85,
                  height: 25,
                ),
              ],
            ),
          ),
          const _GridViewSkeleton(),
        ],
      ),
    );
  }
}

class _GridViewSkeleton extends StatelessWidget {
  const _GridViewSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return const Skeleton();
      },
    );
  }
}
