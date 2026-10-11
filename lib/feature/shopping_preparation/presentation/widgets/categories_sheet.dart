import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:shopengo/core/presentation/widgets/grouped_card.dart';
import 'package:shopengo/core/presentation/widgets/sheet_drag_handle.dart';
import 'package:shopengo/core/presentation/widgets/sheet_header.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/feature/category/presentation/add_category_sheet.dart';
import 'package:shopengo/feature/category/presentation/category_model_extension.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_bloc.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_event.dart';
import 'package:shopengo/feature/shopping_preparation/domain/cubit/shopping_preparation_state.dart';
import 'package:shopengo/generated/assets.gen.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class CategoriesSheet extends StatelessWidget {
  const new({super.key});

  static Future<void> show(BuildContext context) {
    final bloc = context.read<ShoppingPreparationBloc>();
    return showAppBottomSheet<void>(
      context,
      builder: (context) => BlocProvider.value(value: bloc, child: const CategoriesSheet()),
    );
  }

  Future<void> _onNewCategoryPressed(BuildContext context) async {
    final bloc = context.read<ShoppingPreparationBloc>();
    final category = await AddCategorySheet.show(context);
    if (category != null) {
      bloc.add(ShoppingPreparationCreateCategoryEvent(title: category.title, color: category.color));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: constraints.maxHeight - fullHeightSheetTopGap,
        child: Column(
          children: [
            const SheetDragHandle(),
            SheetHeader(
              title: LocaleKeys.categoriesSheet_title.tr(),
              buttonText: LocaleKeys.categoriesSheet_back.tr(),
              onButtonPressed: () => context.pop(),
            ),
            Expanded(
              child: BlocBuilder<ShoppingPreparationBloc, ShoppingPreparationState>(
                buildWhen: (previous, current) => previous.categories != current.categories,
                builder: (context, state) => ListView(
                  padding: EdgeInsets.fromLTRB(20, 4, 20, 30 + MediaQuery.paddingOf(context).bottom),
                  children: [
                    _NewCategoryButton(onPressed: () => _onNewCategoryPressed(context)),
                    const SizedBox(height: 14),
                    GroupedCard(children: [for (final category in state.categories) _CategoryRow(category: category)]),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        LocaleKeys.categoriesSheet_defaultCategoryNote.tr(),
                        style: CustomTextStyles.of(context).regular13
                            .copyWith(color: CustomColors.of(context).mutedText),
                      ),
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

class _NewCategoryButton extends StatelessWidget {
  const new({required this.onPressed});

  final VoidCallback onPressed;

  static const double _radius = 16;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return CustomPaint(
      foregroundPainter: _DashedBorderPainter(color: colors.outline, radius: _radius),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(_radius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          splashColor: colors.highlight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
                  child: Center(child: Assets.icon.plus.svg(width: 18, height: 18)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    LocaleKeys.categoriesSheet_newCategory.tr(),
                    style: CustomTextStyles.of(context).semiBold16.copyWith(color: colors.accentText),
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

class _DashedBorderPainter extends CustomPainter {
  const new({required this.color, required this.radius});

  final Color color;
  final double radius;

  static const double _strokeWidth = 1.5;
  static const double _dashLength = 5;
  static const double _gapLength = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(_strokeWidth / 2);
    final path = Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;

    for (final metric in path.computeMetrics()) {
      for (double start = 0; start < metric.length; start += _dashLength + _gapLength) {
        canvas.drawPath(metric.extractPath(start, start + _dashLength), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) => color != oldDelegate.color || radius != oldDelegate.radius;
}

class _CategoryRow extends StatelessWidget {
  const new({required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    return ColoredBox(
      color: colors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: category.color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.displayTitle,
                    style: textStyles.medium15.copyWith(color: colors.dark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    LocaleKeys.categoriesSheet_productCount.plural(category.productCount),
                    style: textStyles.regular12.copyWith(color: colors.mutedText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
