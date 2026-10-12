import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:shopengo/core/presentation/widgets/sheet_drag_handle.dart';
import 'package:shopengo/core/presentation/widgets/sheet_header.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/feature/category/presentation/category_palette.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

typedef CategoryDetails = ({String title, Color color});

/// Creates a category, or edits [category] when it's given.
class CategorySheet extends StatefulWidget {
  const new({this.category, this.onDeletePressed, super.key});

  final CategoryModel? category;

  /// Shows a delete button when editing.
  final VoidCallback? onDeletePressed;

  static const int _maxTitleLength = 32;

  /// Returns the entered category, or null if the sheet was dismissed.
  static Future<CategoryDetails?> showNew(BuildContext context) {
    return AppBottomSheet.show<CategoryDetails>(context, builder: (context) => const CategorySheet());
  }

  /// Returns the edited title and color, or null if the sheet was dismissed or the category was deleted.
  static Future<CategoryDetails?> showEdit(
    BuildContext context, {
    required CategoryModel category,
    required VoidCallback onDeletePressed,
  }) {
    return AppBottomSheet.show<CategoryDetails>(
      context,
      builder: (context) => CategorySheet(category: category, onDeletePressed: onDeletePressed),
    );
  }

  @override
  State<CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends State<CategorySheet> {
  late final _controller = TextEditingController(text: widget.category?.title);
  late Color _color = widget.category?.color ?? CategoryPalette.colors.first;

  bool get _isEditing => widget.category != null;

  String get _title => _controller.text.trim();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_title.isEmpty) {
      return;
    }
    context.pop<CategoryDetails>((title: _title, color: _color));
  }

  void _onDelete() {
    widget.onDeletePressed?.call();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.viewInsetsOf(context).bottom + MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetDragHandle(),
          SheetHeader(
            title: _isEditing ? LocaleKeys.editCategorySheet_title.tr() : LocaleKeys.addCategorySheet_title.tr(),
            buttonText: LocaleKeys.addCategorySheet_back.tr(),
            onButtonPressed: () => context.pop(),
          ),
          Flexible(
            // Scrolls when the keyboard leaves too little room on small phones.
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TitleField(
                    controller: _controller,
                    autofocus: !_isEditing,
                    onChanged: (_) => setState(() {}),
                    onSubmitted: (_) => _onSave(),
                  ),
                  const SizedBox(height: 22),
                  _SectionLabel(text: LocaleKeys.addCategorySheet_color.tr()),
                  const SizedBox(height: 10),
                  _ColorPicker(selectedColor: _color, onColorSelected: (color) => setState(() => _color = color)),
                  const SizedBox(height: 20),
                  _SectionLabel(text: LocaleKeys.addCategorySheet_preview.tr()),
                  const SizedBox(height: 10),
                  _CategoryChip(title: _title, color: _color),
                  const SizedBox(height: 28),
                  _SaveButton(
                    text: _isEditing ? LocaleKeys.editCategorySheet_save.tr() : LocaleKeys.addCategorySheet_save.tr(),
                    onPressed: _title.isEmpty ? null : _onSave,
                  ),
                  if (widget.onDeletePressed != null) ...[
                    const SizedBox(height: 10),
                    _DeleteButton(onPressed: _onDelete),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const new({required this.controller, required this.autofocus, required this.onChanged, required this.onSubmitted});

  final TextEditingController controller;
  final bool autofocus;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    final textStyle = CustomTextStyles.of(context).regular17;
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary, width: 2),
      ),
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.done,
        inputFormatters: [LengthLimitingTextInputFormatter(CategorySheet._maxTitleLength)],
        style: textStyle.copyWith(color: colors.dark),
        cursorColor: colors.primary,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: LocaleKeys.addCategorySheet_titleHint.tr(),
          hintStyle: textStyle.copyWith(color: colors.hintText),
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

class _ColorPicker extends StatelessWidget {
  const new({required this.selectedColor, required this.onColorSelected});

  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  static const int _columns = 6;

  @override
  Widget build(BuildContext context) {
    const colors = CategoryPalette.colors;
    return Column(
      spacing: 8,
      children: [
        for (var start = 0; start < colors.length; start += _columns)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final color in colors.skip(start).take(_columns))
                _ColorSwatch(color: color, isSelected: color == selectedColor, onPressed: () => onColorSelected(color)),
            ],
          ),
      ],
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const new({required this.color, required this.isSelected, required this.onPressed});

  final Color color;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? CustomColors.of(context).dark : Colors.transparent, width: 2),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const new({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Color.alphaBlend(color.withValues(alpha: 0.2), colors.background),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              title.isEmpty ? LocaleKeys.addCategorySheet_previewPlaceholder.tr() : title,
              style: CustomTextStyles.of(context).medium14
                  .copyWith(color: title.isEmpty ? colors.hintText : colors.dark),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const new({required this.text, required this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: colors.primary,
          disabledBackgroundColor: colors.primary.withValues(alpha: 0.5),
          foregroundColor: colors.primaryText,
          disabledForegroundColor: colors.primaryText,
          shape: const StadiumBorder(),
        ),
        child: Text(text, style: CustomTextStyles.of(context).semiBold16),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const new({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = CustomColors.of(context);
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: colors.background,
          foregroundColor: colors.danger,
          shape: StadiumBorder(side: BorderSide(color: colors.danger.withValues(alpha: 0.3))),
        ),
        child: Text(LocaleKeys.editCategorySheet_delete.tr(), style: CustomTextStyles.of(context).semiBold16),
      ),
    );
  }
}
