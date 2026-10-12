import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:basketwise/core/presentation/style/custom_text_styles.dart';
import 'package:basketwise/feature/category/domain/model/category_model.dart';
import 'package:basketwise/feature/category/presentation/category_model_extension.dart';
import 'package:flutter/material.dart';

class CategorySelectionChip extends StatelessWidget {
  const new({required this.category, required this.isSelected, required this.onPressed, super.key});

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
