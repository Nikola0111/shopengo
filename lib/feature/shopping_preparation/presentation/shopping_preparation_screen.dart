import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/feature/shopping_preparation/presentation/widgets/shopping_preparation_content.dart';
import 'package:shopengo/feature/shopping_preparation/presentation/widgets/shopping_preparation_header.dart';

class ShoppingPreparationScreen extends StatelessWidget {
  const new({required this.store, super.key});
  static const path = 'shopping-preparation';

  final StoreModel store;

  static const double _bodyRadius = 28;
  static const double _contentHeight = 172;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.of(context).primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ShoppingPreparationHeader(store: store, onBackPressed: () => context.pop(), onHistoryPressed: () {}),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: CustomColors.of(context).surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(_bodyRadius)),
                ),
                child: Stack(
                  children: [
                    ListView(padding: const EdgeInsets.fromLTRB(20, 20, 20, _contentHeight)),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ShoppingPreparationContent(onAddPressed: () {}, onStartShoppingPressed: () {}),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
