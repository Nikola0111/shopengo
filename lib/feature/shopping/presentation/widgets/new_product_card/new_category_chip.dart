import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/dashed_border_painter.dart';
import 'package:shopengo/feature/category/presentation/category_sheet.dart';
import 'package:shopengo/feature/shopping/domain/cubit/shopping_bloc.dart';
import 'package:shopengo/feature/shopping/domain/cubit/shopping_event.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class NewCategoryChip extends StatelessWidget {
  const new({required this.onPressed, super.key});

  final VoidCallback onPressed;

  /// Opens the new category sheet and returns the created category's id, or null if the sheet was dismissed.
  static Future<int?> createCategory(BuildContext context) async {
    final bloc = context.read<ShoppingBloc>();
    final category = await CategorySheet.showNew(context);
    if (category == null) {
      return null;
    }

    final existingIds = bloc.state.categories.map((e) => e.id).toSet();
    bloc.add(ShoppingCreateCategoryEvent(title: category.title, color: category.color));
    final state = await bloc.stream.firstWhere((state) => state.categories.any((e) => !existingIds.contains(e.id)));
    return state.categories.firstWhere((e) => !existingIds.contains(e.id)).id;
  }

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: CustomPaint(
        foregroundPainter: DashedBorderPainter(color: colors.outline, radius: 16, strokeWidth: 1),
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12.5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              Text('+', style: textStyles.medium16.copyWith(color: colors.accentText, height: 1)),
              Text(
                LocaleKeys.addProductSheet_newCategory.tr(),
                style: textStyles.medium14.copyWith(color: colors.accentText, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
