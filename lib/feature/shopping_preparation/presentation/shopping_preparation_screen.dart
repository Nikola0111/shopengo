import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/core/domain/repository/di.dart' show container;
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/feature/cart/data/repository/cart_repository_impl.dart';
import 'package:shopengo/feature/category/data/repository/category_repository_impl.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/feature/product/data/repository/product_repository_impl.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_bloc.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_event.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_state.dart';
import 'package:shopengo/feature/shopping_preparation/presentation/widgets/add_product_sheet.dart';
import 'package:shopengo/feature/shopping_preparation/presentation/widgets/shopping_list/shopping_list_section.dart';
import 'package:shopengo/feature/shopping_preparation/presentation/widgets/shopping_preparation_content.dart';
import 'package:shopengo/feature/shopping_preparation/presentation/widgets/shopping_preparation_header.dart';

class ShoppingPreparationScreen extends StatelessWidget {
  const new({required this.store, super.key});
  static const path = 'shopping-preparation';

  final StoreModel store;

  static const double _bodyRadius = 28;
  static const double _contentHeight = 172;
  static const double _sectionSpacing = 22;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShoppingPreparationBloc>(
      create: (context) => ShoppingPreparationBloc(
        container.resolve<ProductRepositoryImpl>(),
        container.resolve<CartRepositoryImpl>(),
        container.resolve<CategoryRepositoryImpl>(),
        storeId: store.id,
      )..add(ShoppingPreparationLoadProductsEvent()),
      child: Builder(builder: _buildScreen),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.of(context).primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            BlocSelector<ShoppingPreparationBloc, ShoppingPreparationState, int>(
              selector: (state) => state.cartQuantities.length,
              builder: (context, productCount) => ShoppingPreparationHeader(
                store: store,
                productCount: productCount,
                onBackPressed: () => context.pop(),
                onHistoryPressed: () {},
              ),
            ),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: CustomColors.of(context).surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(_bodyRadius)),
                ),
                child: BlocBuilder<ShoppingPreparationBloc, ShoppingPreparationState>(
                  builder: (context, state) {
                    final shoppingList = state.shoppingList;
                    return Stack(
                      children: [
                        ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, _contentHeight),
                          itemCount: shoppingList.length,
                          separatorBuilder: (context, index) => const SizedBox(height: _sectionSpacing),
                          itemBuilder: (context, index) {
                            final (:category, :items) = shoppingList[index];
                            return ShoppingListSection(
                              category: category,
                              items: items,
                              onIncreasePressed: (product) => context.read<ShoppingPreparationBloc>().add(
                                ShoppingPreparationAddProductEvent(productId: product.id),
                              ),
                              onDecreasePressed: (product) => context.read<ShoppingPreparationBloc>().add(
                                ShoppingPreparationDecreaseQuantityEvent(productId: product.id),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ShoppingPreparationContent(
                            onAddPressed: () => AddProductSheet.show(context, store: store),
                            onStartShoppingPressed: shoppingList.isEmpty ? null : () {},
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
