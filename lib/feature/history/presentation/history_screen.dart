import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/core/domain/repository/di.dart' show container;
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/feature/history/data/repository/history_repository_impl.dart';
import 'package:shopengo/feature/history/domain/cubit/history_bloc.dart';
import 'package:shopengo/feature/history/domain/cubit/history_event.dart';
import 'package:shopengo/feature/history/domain/cubit/history_state.dart';
import 'package:shopengo/feature/history/presentation/widgets/history_header.dart';
import 'package:shopengo/feature/history/presentation/widgets/shopping_history_card.dart';
import 'package:shopengo/feature/home/domain/model/store_model.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

/// A store's finished shoppings, newest first, with what was bought and spent in each.
class HistoryScreen extends StatelessWidget {
  const new({required this.store, super.key});
  static const path = 'history';

  final StoreModel store;

  static const double _bodyRadius = 28;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryBloc>(
      create: (context) =>
          HistoryBloc(container.resolve<HistoryRepositoryImpl>(), storeId: store.id)..add(HistoryLoadEvent()),
      child: Scaffold(
        backgroundColor: CustomColors.of(context).primary,
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) => Column(
              children: [
                HistoryHeader(
                  store: store,
                  shoppingCount: state.shoppingHistory.length,
                  totalSpent: state.totalSpent,
                  onBackPressed: () => context.pop(),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: CustomColors.of(context).surface,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(_bodyRadius)),
                    ),
                    child: switch (state) {
                      HistoryState(isLoading: true) => const SizedBox.shrink(),
                      HistoryState(shoppingHistory: []) => const _EmptyHistory(),
                      _ => ListView.separated(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 40 + MediaQuery.paddingOf(context).bottom),
                        itemCount: state.shoppingHistory.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final shopping = state.shoppingHistory[index];
                          return ShoppingHistoryCard(
                            key: ValueKey(shopping.id),
                            shopping: shopping,
                            currency: store.displayCurrency,
                          );
                        },
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 48, 32, 0),
      child: Column(
        children: [
          Text(
            LocaleKeys.history_empty.tr(),
            textAlign: TextAlign.center,
            style: textStyles.semiBold16.copyWith(color: colors.dark),
          ),
          const SizedBox(height: 6),
          Text(
            LocaleKeys.history_emptyDescription.tr(),
            textAlign: TextAlign.center,
            style: textStyles.regular14.copyWith(color: colors.bodyText, height: 1.45),
          ),
        ],
      ),
    );
  }
}
