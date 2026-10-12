import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:basketwise/core/presentation/style/custom_text_styles.dart';
import 'package:basketwise/generated/assets.gen.dart';
import 'package:basketwise/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NewProductCardHeader extends StatelessWidget {
  const new({required this.name, required this.isExpanded, required this.onPressed, super.key});

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
