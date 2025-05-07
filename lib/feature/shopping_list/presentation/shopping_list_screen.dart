import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/core/domain/repository/di.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/rounded_button.dart';
import 'package:shopengo/feature/home/data/repository/store_repository_impl.dart';
import 'package:shopengo/feature/shopping_list/data/repository/shopping_list_repository_impl.dart';
import 'package:shopengo/feature/shopping_list/domain/cubit/shopping_list_bloc.dart';
import 'package:shopengo/feature/shopping_list/domain/cubit/shopping_list_event.dart';
import 'package:shopengo/feature/shopping_list/domain/cubit/shopping_list_state.dart';
import 'package:shopengo/feature/shopping_list/presentation/widgets/shopping_items_section.dart';
import 'package:shopengo/feature/shopping_list/presentation/widgets/shopping_list_section.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({required this.storeID, super.key});

  static const path = 'shopping-list/:storeID';

  final int storeID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.of(context).primary,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ShoppingListBloc(
            container.resolve<StoreRepositoryImpl>(),
            container.resolve<ShoppingListRepositoryImpl>(),
            storeID,
          )..add(const ShoppingListLoadDataEvent()),
          child: BlocBuilder<ShoppingListBloc, ShoppingListState>(
            builder: (context, state) {
              return Column(
                children: [
                  _Header(
                    storeName: state.selectedStore.storeName,
                    onViewHistory: () {},
                    onDeleteStore: () {},
                  ),
                  const SizedBox(height: 24),
                  ShoppingListSection(
                    shoppingListModel: state.shoppingList,
                    onCreateAndAddGrocery: (value) {
                      context.read<ShoppingListBloc>().add(ShoppingListCreateAddGrocery(groceryName: value));
                    },
                    onFilter: (value) {},
                  ),
                  const SizedBox(height: 12),
                  ShoppingItemsSection(shoppingItems: state.shoppingItems),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.storeName, required this.onViewHistory, required this.onDeleteStore});

  final String storeName;
  final VoidCallback onViewHistory;
  final VoidCallback onDeleteStore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 12),
      child: Row(
        children: [
          Text(
            storeName,
            style: CustomTextStyles.of(context).medium24,
          ),
          const Spacer(),
          RoundedButton(
            icon: Icons.history,
            backgroundColor: CustomColors.of(context).undoColor,
            iconColor: CustomColors.of(context).background,
            onPressed: () {},
          ),
          const SizedBox(width: 12),
          RoundedButton(
            icon: Icons.delete_outline_outlined,
            backgroundColor: CustomColors.of(context).cancel,
            iconColor: CustomColors.of(context).background,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
