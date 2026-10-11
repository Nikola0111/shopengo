import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';

/// Rows on a rounded card, separated by 1px dividers.
class GroupedCard extends StatelessWidget {
  const new({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final dividerColor = CustomColors.of(context).divider;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: dividerColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: dividerColor),
      ),
      // Sits inside the sheet's scrolling list, so it sizes to its rows and doesn't scroll on its own.
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) => const SizedBox(height: 1),
      ),
    );
  }
}
