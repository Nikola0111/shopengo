import 'package:flutter/material.dart';
import 'package:shopengo/generated/fonts.gen.dart';

class CustomTextStyles {
  const CustomTextStyles.of(BuildContext context) : _context = context;
  final BuildContext _context;

  TextStyle get regular14 => Theme.of(_context).extension<CustomTextStyleScheme>()!.regular14!;
  TextStyle get regular18 => Theme.of(_context).extension<CustomTextStyleScheme>()!.regular18!;
  TextStyle get medium12 => Theme.of(_context).extension<CustomTextStyleScheme>()!.medium12!;
  TextStyle get medium16 => Theme.of(_context).extension<CustomTextStyleScheme>()!.medium16!;
  TextStyle get medium20 => Theme.of(_context).extension<CustomTextStyleScheme>()!.medium20!;
  TextStyle get medium24 => Theme.of(_context).extension<CustomTextStyleScheme>()!.medium24!;
}

@immutable
class CustomTextStyleScheme extends ThemeExtension<CustomTextStyleScheme> {
  const CustomTextStyleScheme({
    required this.regular14,
    required this.regular18,
    required this.medium12,
    required this.medium16,
    required this.medium20,
    required this.medium24,
  });

  factory CustomTextStyleScheme.fromPrimaryTextColor({required Color primaryTextColor}) {
    return CustomTextStyleScheme(
      regular14: TextStyle(
        color: primaryTextColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
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
      medium16: TextStyle(
        color: primaryTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: _fontFamilyRubik,
      ),
      medium20: TextStyle(
        color: primaryTextColor,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: _fontFamilyRubik,
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

  final TextStyle? regular14;
  final TextStyle? regular18;
  final TextStyle? medium12;
  final TextStyle? medium16;
  final TextStyle? medium20;
  final TextStyle? medium24;

  @override
  CustomTextStyleScheme copyWith({
    TextStyle? regular14,
    TextStyle? regular18,
    TextStyle? medium12,
    TextStyle? medium16,
    TextStyle? medium20,
    TextStyle? medium24,
  }) {
    return CustomTextStyleScheme(
      regular14: regular14 ?? this.regular14,
      regular18: regular18 ?? this.regular18,
      medium12: medium12 ?? this.medium12,
      medium16: medium16 ?? this.medium16,
      medium20: medium20 ?? this.medium20,
      medium24: medium24 ?? this.medium24,
    );
  }

  @override
  CustomTextStyleScheme lerp(ThemeExtension<CustomTextStyleScheme>? other, double t) {
    if (other is! CustomTextStyleScheme) {
      return this;
    }
    return CustomTextStyleScheme(
      regular14: TextStyle.lerp(regular14, other.regular14, t),
      regular18: TextStyle.lerp(regular18, other.regular18, t),
      medium12: TextStyle.lerp(medium12, other.medium12, t),
      medium16: TextStyle.lerp(medium16, other.medium16, t),
      medium20: TextStyle.lerp(medium20, other.medium20, t),
      medium24: TextStyle.lerp(medium24, other.medium24, t),
    );
  }
}
