import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';

class HomeTextField extends StatelessWidget {
  const HomeTextField({
    required this.isVisible,
    required this.onDone,
    required this.controller,
    required this.onChanged,
    super.key,
  });
  final TextEditingController controller;
  final bool isVisible;
  final VoidCallback onDone;
  final ValueChanged<String?> onChanged;

  static const _duration = Duration(milliseconds: 150);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isVisible ? 48 : 0,
      duration: _duration,
      curve: Curves.easeIn,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: CustomTextStyles.of(context)
            .regular18
            .copyWith(height: 1.01, color: CustomColors.of(context).secondaryText),
        onFieldSubmitted: (_) => onDone(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          fillColor: CustomColors.of(context).background,
          filled: true,
        ),
      ),
    );
  }
}
