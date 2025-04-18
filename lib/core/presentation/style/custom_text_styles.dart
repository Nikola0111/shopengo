import 'package:flutter/material.dart';
import 'package:shopengo/generated/fonts.gen.dart';

class CustomTextStyles {
  const CustomTextStyles.of(BuildContext context) : _context = context;
  final BuildContext _context;

  TextStyle get regular18 => Theme.of(_context).extension<CustomTextStyleScheme>()!.regular18!;
  TextStyle get medium12 => Theme.of(_context).extension<CustomTextStyleScheme>()!.medium12!;
  TextStyle get medium24 => Theme.of(_context).extension<CustomTextStyleScheme>()!.medium24!;
}

@immutable
class CustomTextStyleScheme extends ThemeExtension<CustomTextStyleScheme> {
  const CustomTextStyleScheme({
    required this.regular18,
    required this.medium12,
    required this.medium24,
  });

  factory CustomTextStyleScheme.fromPrimaryTextColor({required Color primaryTextColor}) {
    return CustomTextStyleScheme(
      regular18: TextStyle(
        color: primaryTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.2,
      ),
      medium12: TextStyle(
        color: primaryTextColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: _fontFamilyRubik,
        letterSpacing: 0.5,
      ),
      medium24: TextStyle(
        color: primaryTextColor,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontFamily: _fontFamilyRubik,
      ),
    );
  }

  static const _fontFamilyRubik = FontFamily.rubik;

  final TextStyle? regular18;
  final TextStyle? medium12;
  final TextStyle? medium24;

  @override
  CustomTextStyleScheme copyWith({
    TextStyle? regular18,
    TextStyle? medium12,
    TextStyle? medium24,
  }) {
    return CustomTextStyleScheme(
      regular18: regular18 ?? this.regular18,
      medium12: medium12 ?? this.medium12,
      medium24: medium24 ?? this.medium24,
    );
  }

  @override
  CustomTextStyleScheme lerp(ThemeExtension<CustomTextStyleScheme>? other, double t) {
    if (other is! CustomTextStyleScheme) {
      return this;
    }
    return CustomTextStyleScheme(
      regular18: TextStyle.lerp(regular18, other.regular18, t),
      medium12: TextStyle.lerp(medium12, other.medium12, t),
      medium24: TextStyle.lerp(medium24, other.medium24, t),
    );
  }
}
