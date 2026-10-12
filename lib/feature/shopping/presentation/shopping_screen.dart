import 'package:basketwise/core/domain/repository/di.dart' show container;
import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:basketwise/feature/cart/data/repository/cart_repository_impl.dart';
import 'package:basketwise/feature/category/data/repository/category_repository_impl.dart';
import 'package:basketwise/feature/history/presentation/history_screen.dart';
import 'package:basketwise/feature/home/data/repository/store_repository_impl.dart';
import 'package:basketwise/feature/home/domain/model/store_model.dart';
import 'package:basketwise/feature/product/data/repository/product_repository_impl.dart';
import 'package:basketwise/feature/shopping/domain/cubit/shopping_bloc.dart';
import 'package:basketwise/feature/shopping/domain/cubit/shopping_event.dart';
import 'package:basketwise/feature/shopping/domain/cubit/shopping_state.dart';
import 'package:basketwise/feature/shopping/presentation/widgets/add_product_sheet.dart';
import 'package:basketwise/feature/shopping/presentation/widgets/empty_shopping_list.dart';
import 'package:basketwise/feature/shopping/presentation/widgets/finish_shopping_sheet.dart';
import 'package:basketwise/feature/shopping/presentation/widgets/shopping_bottom_bar.dart';
import 'package:basketwise/feature/shopping/presentation/widgets/shopping_header.dart';
import 'package:basketwise/feature/shopping/presentation/widgets/shopping_list/shopping_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShoppingScreen extends StatelessWidget {
  const new({required this.store, super.key});
  static const path = 'shopping';

  final StoreModel store;

  static const double _bodyRadius = 28;
  static const double _preparationBottomBarHeight = 172;
  static const double _shoppingBottomBarHeight = 150;
  static const double _sectionSpacing = 22;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShoppingBloc>(
      create: (context) => ShoppingBloc(
        container.resolve<ProductRepositoryImpl>(),
        container.resolve<CartRepositoryImpl>(),
        container.resolve<CategoryRepositoryImpl>(),
        container.resolve<StoreRepositoryImpl>(),
        storeId: store.id,
        isShopping: store.isShopping,
        previousShoppingAmountSpent: store.previousShoppingAmountSpent,
      )..add(ShoppingLoadProductsEvent()),
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
            BlocSelector<
              ShoppingBloc,
              ShoppingState,
              ({bool isShopping, int productCount, int checkedCount, double? previousShoppingAmountSpent})
            >(
              selector: (state) => (
                isShopping: state.isShopping,
                productCount: state.cartQuantities.length,
                checkedCount: state.checkedProductIds.length,
                previousShoppingAmountSpent: state.previousShoppingAmountSpent,
              ),
              builder: (context, header) => ShoppingHeader(
                store: store,
                isShopping: header.isShopping,
                productCount: header.productCount,
                checkedCount: header.checkedCount,
                previousShoppingAmountSpent: header.previousShoppingAmountSpent,
                onBackPressed: () => context.pop(),
                onHistoryPressed: () => context.pushNamed(HistoryScreen.path, extra: store),
                onBackToPreparationPressed: () => context.read<ShoppingBloc>().add(ShoppingBackToPreparationEvent()),
              ),
            ),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: CustomColors.of(context).surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(_bodyRadius)),
                ),
                child: BlocBuilder<ShoppingBloc, ShoppingState>(
                  builder: (context, state) {
                    final shoppingList = state.shoppingList;
                    return Stack(
                      children: [
                        if (shoppingList.isEmpty)
                          const Align(alignment: Alignment.topCenter, child: EmptyShoppingList())
                        else
                          ListView.separated(
                            padding: EdgeInsets.fromLTRB(
                              20,
                              20,
                              20,
                              state.isShopping ? _shoppingBottomBarHeight : _preparationBottomBarHeight,
                            ),
                            itemCount: shoppingList.length,
                            separatorBuilder: (context, index) => const SizedBox(height: _sectionSpacing),
                            itemBuilder: (context, index) {
                              final (:category, :items) = shoppingList[index];
                              return ShoppingListSection(
                                category: category,
                                items: items,
                                isShopping: state.isShopping,
                                onIncreasePressed: (product) =>
                                    context.read<ShoppingBloc>().add(ShoppingAddProductEvent(productId: product.id)),
                                onDecreasePressed: (product) => context.read<ShoppingBloc>().add(
                                  ShoppingDecreaseQuantityEvent(productId: product.id),
                                ),
                                onCheckPressed: (product) =>
                                    context.read<ShoppingBloc>().add(ShoppingToggleCheckedEvent(productId: product.id)),
                              );
                            },
                          ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ShoppingBottomBar(
                            isShopping: state.isShopping,
                            onAddPressed: () => AddProductSheet.show(context, store: store),
                            onStartShoppingPressed: shoppingList.isEmpty
                                ? null
                                : () => context.read<ShoppingBloc>().add(ShoppingStartShoppingEvent()),
                            onFinishShoppingPressed: () => _onFinishShoppingPressed(context),
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

  Future<void> _onFinishShoppingPressed(BuildContext context) async {
    final bloc = context.read<ShoppingBloc>();
    final finishedShopping = await FinishShoppingSheet.show(
      context,
      checkedCount: bloc.state.checkedProductIds.length,
      productCount: bloc.state.cartQuantities.length,
      currency: store.displayCurrency,
    );
    if (finishedShopping != null) {
      bloc.add(ShoppingFinishEvent(amountSpent: finishedShopping.amountSpent));
    }
  }
}
