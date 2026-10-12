import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';
import 'package:shopengo/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:shopengo/core/presentation/widgets/sheet_drag_handle.dart';
import 'package:shopengo/core/presentation/widgets/sheet_header.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

class NewStoreSheet extends StatefulWidget {
  const new({super.key});

  /// Returns the entered store name, or null if the sheet was dismissed.
  static Future<String?> show(BuildContext context) {
    return AppBottomSheet.show<String>(context, builder: (context) => const NewStoreSheet());
  }

  @override
  State<NewStoreSheet> createState() => _NewStoreSheetState();
}

class _NewStoreSheetState extends State<NewStoreSheet> {
  final _controller = TextEditingController();

  String get _name => _controller.text.trim();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onAdd() {
    if (_name.isEmpty) {
      return;
    }
    context.pop<String>(_name);
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
            title: LocaleKeys.newStoreSheet_title.tr(),
            buttonText: LocaleKeys.newStoreSheet_done.tr(),
            onButtonPressed: () => context.pop(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                _NameField(controller: _controller, onChanged: (_) => setState(() {}), onSubmitted: (_) => _onAdd()),
                const SizedBox(height: 14),
                _AddButton(onPressed: _name.isEmpty ? null : _onAdd),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const new({required this.controller, required this.onChanged, required this.onSubmitted});

  final TextEditingController controller;
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
        border: Border.all(color: colors.primary, width: 1.5),
      ),
      child: TextField(
        controller: controller,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.done,
        style: textStyle.copyWith(color: colors.dark),
        cursorColor: colors.primary,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: LocaleKeys.newStoreSheet_nameHint.tr(),
          hintStyle: textStyle.copyWith(color: colors.hintText),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const new({required this.onPressed});

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
        child: Text(LocaleKeys.newStoreSheet_add.tr(), style: CustomTextStyles.of(context).semiBold16),
      ),
    );
  }
}
