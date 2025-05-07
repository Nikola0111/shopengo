import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/feature/shopping_list/domain/model/shopping_item_model.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class ShoppingItemsSection extends StatefulWidget {
  const ShoppingItemsSection({required this.shoppingItems, required this.onAddToShoppingList, super.key});

  final List<ShoppingItemModel> shoppingItems;
  final void Function(int id) onAddToShoppingList;

  @override
  State<ShoppingItemsSection> createState() => _ShoppingItemsSectionState();
}

class _ShoppingItemsSectionState extends State<ShoppingItemsSection> {
  final _shoppingItemsExpandableController = ExpandableController(initialExpanded: true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(LocaleKeys.shoppingList_otherShoppingItems, style: CustomTextStyles.of(context).medium20).tr(),
              const Spacer(),
              IconButton(
                onPressed: () {
                  _shoppingItemsExpandableController.toggle();
                  setState(() {});
                },
                icon: Transform.rotate(
                  angle: _shoppingItemsExpandableController.expanded ? -pi / 2 : pi / 2,
                  child: Icon(
                    Icons.chevron_left,
                    color: CustomColors.of(context).background,
                  ),
                ),
              ),
            ],
          ),
          ExpandableNotifier(
            controller: _shoppingItemsExpandableController,
            child: Expandable(
              collapsed: const SizedBox.shrink(),
              expanded: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.shoppingItems.length,
                itemBuilder: (context, index) {
                  final item = widget.shoppingItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text(item.name, style: CustomTextStyles.of(context).regular18),
                        const Spacer(),
                        IconButton(
                          onPressed: () => widget.onAddToShoppingList(item.id),
                          icon: Icon(
                            Icons.add,
                            color: CustomColors.of(context).background,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
