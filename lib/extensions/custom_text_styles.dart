import 'package:flutter/material.dart';

extension CustomTextStyles on BuildContext {
  TextStyle get regular18 => Theme.of(this).extension<CustomTextStyleScheme>()!.regular18!;
}

@immutable
class CustomTextStyleScheme extends ThemeExtension<CustomTextStyleScheme> {
  final TextStyle? regular18;

  const CustomTextStyleScheme({
    required this.regular18,
  });

  factory CustomTextStyleScheme.fromPrimaryTextColor({required Color primaryTextColor}) {
    return CustomTextStyleScheme(
      regular18: TextStyle(
        color: primaryTextColor,
        fontSize: 18,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  @override
  CustomTextStyleScheme copyWith({
    TextStyle? regular18,
  }) {
    return CustomTextStyleScheme(
      regular18: regular18 ?? this.regular18,
    );
  }

  @override
  CustomTextStyleScheme lerp(ThemeExtension<CustomTextStyleScheme>? other, double t) {
    if (other is! CustomTextStyleScheme) {
      return this;
    }
    return CustomTextStyleScheme(
      regular18: TextStyle.lerp(regular18, other.regular18, t),
    );
  }
}
