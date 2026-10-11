import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/dashed_border_painter.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/feature/category/presentation/category_model_extension.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';
import 'package:shopengo/feature/product/presentation/amount_type_extension.dart';
import 'package:shopengo/generated/assets.gen.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

/// Offers to create a product named [name], expanding to pick its unit and category before saving.
class NewProductCard extends StatelessWidget {
  const new({
    required this.name,
    required this.isExpanded,
    required this.onExpandToggled,
    required this.amountType,
    required this.onAmountTypeSelected,
    required this.categories,
    required this.categoryId,
    required this.onCategorySelected,
    required this.onNewCategoryPressed,
    required this.onSavePressed,
    super.key,
  });

  final String name;
  final bool isExpanded;
  final VoidCallback onExpandToggled;
  final AmountType amountType;
  final ValueChanged<AmountType> onAmountTypeSelected;
  final List<CategoryModel> categories;
  final int categoryId;
  final ValueChanged<int> onCategorySelected;
  final VoidCallback onNewCategoryPressed;
  final VoidCallback onSavePressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outline),
      ),
      child: Column(
        children: [
          _Header(name: name, isExpanded: isExpanded, onPressed: onExpandToggled),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: isExpanded
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: colors.divider)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionLabel(text: LocaleKeys.addProductSheet_unit.tr()),
                          const SizedBox(height: 8),
                          _AmountTypePicker(selectedAmountType: amountType, onSelected: onAmountTypeSelected),
                          const SizedBox(height: 14),
                          _SectionLabel(text: LocaleKeys.addProductSheet_category.tr()),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              for (final category in categories)
                                _CategoryChip(
                                  category: category,
                                  isSelected: category.id == categoryId,
                                  onPressed: () => onCategorySelected(category.id),
                                ),
                              _NewCategoryChip(onPressed: onNewCategoryPressed),
                            ],
                          ),
                          const SizedBox(height: 14),
                          _SaveButton(onPressed: onSavePressed),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const new({required this.name, required this.isExpanded, required this.onPressed});

  final String name;
  final bool isExpanded;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyles = CustomTextStyles.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        splashColor: colors.highlight,
        highlightColor: colors.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
                child: Center(child: Assets.icon.plus.svg(width: 18, height: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      LocaleKeys.addProductSheet_newProductTitle.tr(namedArgs: {'name': name}),
                      style: textStyles.semiBold16.copyWith(color: colors.dark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      LocaleKeys.addProductSheet_newProductSubtitle.tr(),
                      style: textStyles.regular13.copyWith(color: colors.mutedText),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // The icon points left, so a quarter turn either way points it up or down.
              AnimatedRotation(
                turns: isExpanded ? 0.25 : -0.25,
                duration: const Duration(milliseconds: 200),
                child: Assets.icon.chevronLeft.svg(
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(colors.mutedText, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const new({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: CustomTextStyles.of(context).semiBold12
          .copyWith(color: CustomColors.of(context).sectionLabel, letterSpacing: 1),
    );
  }
}

class _AmountTypePicker extends StatelessWidget {
  const new({required this.selectedAmountType, required this.onSelected});

  final AmountType selectedAmountType;
  final ValueChanged<AmountType> onSelected;

  static const List<AmountType> _amountTypes = [
    AmountType.piece,
    AmountType.kilogram,
    AmountType.gram,
    AmountType.liter,
    AmountType.pack,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyle = CustomTextStyles.of(context).medium14;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(
        spacing: 6,
        children: [
          for (final amountType in _amountTypes)
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(amountType),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: amountType == selectedAmountType
                        ? colors.background
                        : colors.background.withValues(alpha: 0),
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      if (amountType == selectedAmountType)
                        const BoxShadow(color: Color(0x26281E78), offset: Offset(0, 1), blurRadius: 1.5),
                    ],
                  ),
                  child: Text(
                    amountType.shortLabel,
                    style: textStyle.copyWith(
                      color: amountType == selectedAmountType ? colors.dark : colors.sectionLabel,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const new({required this.category, required this.isSelected, required this.onPressed});

  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 32,
        padding: const EdgeInsets.only(left: 9.5, right: 12.5),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.alphaBlend(category.color.withValues(alpha: 0.15), colors.background)
              : colors.background,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: isSelected ? category.color : colors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: category.color, shape: BoxShape.circle),
            ),
            Flexible(
              child: Text(
                category.displayTitle,
                style: CustomTextStyles.of(context).regular13.copyWith(color: colors.dark),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewCategoryChip extends StatelessWidget {
  const new({required this.onPressed});

  final VoidCallback onPressed;

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

class _SaveButton extends StatelessWidget {
  const new({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.primaryText,
          shape: const StadiumBorder(),
        ),
        child: Text(LocaleKeys.addProductSheet_saveAndAdd.tr(), style: CustomTextStyles.of(context).semiBold15),
      ),
    );
  }
}
