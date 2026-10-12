import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          for (final (index, child) in children.indexed) ...[if (index > 0) const SizedBox(height: 1), child],
        ],
      ),
    );
  }
}
