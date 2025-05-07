import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/feature/shopping_list/domain/model/shopping_list_model.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class ShoppingListSection extends StatefulWidget {
  const ShoppingListSection({
    required this.shoppingListModel,
    required this.onCreateAndAddGrocery,
    required this.onFilter,
    required this.onRemoveFromList,
    super.key,
  });

  final ShoppingListModel shoppingListModel;
  final void Function(String name) onCreateAndAddGrocery;
  final void Function(String value) onFilter;
  final void Function(int id) onRemoveFromList;

  @override
  State<ShoppingListSection> createState() => _ShoppingListSectionState();
}

class _ShoppingListSectionState extends State<ShoppingListSection> {
  static const _duration = Duration(milliseconds: 150);
  final _shoppingItemsExpandableController = ExpandableController(initialExpanded: true);
  final _controller = TextEditingController();
  bool _isTextFieldVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(LocaleKeys.shoppingList_subtitle, style: CustomTextStyles.of(context).medium20).tr(),
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
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isTextFieldVisible = !_isTextFieldVisible;
                  });
                },
                child: Icon(
                  _isTextFieldVisible ? Icons.close : Icons.add,
                  color: CustomColors.of(context).background,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _isTextFieldVisible ? 12 : 0),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    height: _isTextFieldVisible ? 48 : 0,
                    duration: _duration,
                    curve: Curves.easeIn,
                    child: TextFormField(
                      controller: _controller,
                      onChanged: widget.onFilter,
                      style: CustomTextStyles.of(context)
                          .regular18
                          .copyWith(height: 1.01, color: CustomColors.of(context).secondaryText),
                      onFieldSubmitted: (value) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: CustomColors.of(context).background,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedContainer(
                  duration: _duration,
                  curve: Curves.easeIn,
                  height: _isTextFieldVisible ? 48 : 0,
                  width: 48,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(CustomColors.of(context).confirm),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                    onPressed: () {
                      widget.onCreateAndAddGrocery(_controller.text);
                      _controller.clear();
                    },
                    child: Icon(
                      Icons.check,
                      color: CustomColors.of(context).background,
                      size: _isTextFieldVisible ? 24 : 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ExpandableNotifier(
            controller: _shoppingItemsExpandableController,
            child: Expandable(
              collapsed: const SizedBox.shrink(),
              expanded: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.shoppingListModel.shoppingItems.length,
                itemBuilder: (context, index) {
                  final item = widget.shoppingListModel.shoppingItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text(item.name, style: CustomTextStyles.of(context).regular18),
                        const Spacer(),
                        IconButton(
                          onPressed: () => widget.onRemoveFromList(item.id),
                          icon: Icon(
                            Icons.remove,
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
