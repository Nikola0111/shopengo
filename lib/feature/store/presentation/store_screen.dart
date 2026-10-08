import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/feature/store/presentation/widgets/store_app_bar.dart';
import 'package:shopengo/feature/store/presentation/widgets/store_bottom_bar.dart';

class StoreScreen extends StatelessWidget {
  const new({required this.store, super.key});
  static const path = 'store';

  final StoreModel store;

  static const double _bodyRadius = 28;
  static const double _bottomBarHeight = 172;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.of(context).primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            StoreAppBar(store: store, onBackPressed: () => context.pop(), onHistoryPressed: () {}),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: CustomColors.of(context).surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(_bodyRadius)),
                ),
                child: Stack(
                  children: [
                    ListView(padding: const EdgeInsets.fromLTRB(20, 20, 20, _bottomBarHeight)),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: StoreBottomBar(onAddPressed: () {}, onStartShoppingPressed: () {}),
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
