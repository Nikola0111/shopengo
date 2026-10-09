import 'package:flutter/material.dart';
import 'package:shopengo/generated/fonts.gen.dart';

class CustomTextStyles {
  const new of(BuildContext context) : _context = context;
  final BuildContext _context;

  TextStyle get regular14 => Theme.of(_context).extension<CustomTextStyleScheme>()!.regular14!;
  TextStyle get regular18 => Theme.of(_context).extension<CustomTextStyleScheme>()!.regular18!;
  TextStyle get medium12 => Theme.of(_context).extension<CustomTextStyleScheme>()!.medium12!;
  TextStyle get medium16 => Theme.of(_context).extension<CustomTextStyleScheme>()!.medium16!;
  TextStyle get medium20 => Theme.of(_context).extension<CustomTextStyleScheme>()!.medium20!;
  TextStyle get medium24 => Theme.of(_context).extension<CustomTextStyleScheme>()!.medium24!;
  TextStyle get bold20 => Theme.of(_context).extension<CustomTextStyleScheme>()!.bold20!;
  TextStyle get regular13 => Theme.of(_context).extension<CustomTextStyleScheme>()!.regular13!;
  TextStyle get regular16 => Theme.of(_context).extension<CustomTextStyleScheme>()!.regular16!;
  TextStyle get semiBold11 => Theme.of(_context).extension<CustomTextStyleScheme>()!.semiBold11!;
  TextStyle get semiBold16 => Theme.of(_context).extension<CustomTextStyleScheme>()!.semiBold16!;
  TextStyle get semiBold30 => Theme.of(_context).extension<CustomTextStyleScheme>()!.semiBold30!;
}

@immutable
class CustomTextStyleScheme extends ThemeExtension<CustomTextStyleScheme> {
  const new({
    required this.regular14,
    required this.regular18,
    required this.medium12,
    required this.medium16,
    required this.medium20,
    required this.medium24,
    required this.bold20,
    required this.regular13,
    required this.regular16,
    required this.semiBold11,
    required this.semiBold16,
    required this.semiBold30,
  });

  factory fromPrimaryTextColor({required Color primaryTextColor}) {
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
      bold20: TextStyle(
        color: primaryTextColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: _fontFamilyRubik,
      ),
      regular13: TextStyle(
        color: primaryTextColor,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontFamily: _fontFamilyRubik,
      ),
      regular16: TextStyle(
        color: primaryTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: _fontFamilyRubik,
      ),
      semiBold11: TextStyle(
        color: primaryTextColor,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamilyRubik,
      ),
      semiBold16: TextStyle(
        color: primaryTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamilyRubik,
      ),
      semiBold30: TextStyle(
        color: primaryTextColor,
        fontSize: 30,
        fontWeight: FontWeight.w600,
        fontFamily: _fontFamilyRubik,
      ),
    );
  }

  static const String _fontFamilyRubik = FontFamily.rubik;

  final TextStyle? regular14;
  final TextStyle? regular18;
  final TextStyle? medium12;
  final TextStyle? medium16;
  final TextStyle? medium20;
  final TextStyle? medium24;
  final TextStyle? bold20;
  final TextStyle? regular13;
  final TextStyle? regular16;
  final TextStyle? semiBold11;
  final TextStyle? semiBold16;
  final TextStyle? semiBold30;

  @override
  CustomTextStyleScheme copyWith({
    TextStyle? regular14,
    TextStyle? regular18,
    TextStyle? medium12,
    TextStyle? medium16,
    TextStyle? medium20,
    TextStyle? medium24,
    TextStyle? bold20,
    TextStyle? regular13,
    TextStyle? regular16,
    TextStyle? semiBold11,
    TextStyle? semiBold16,
    TextStyle? semiBold30,
  }) {
    return CustomTextStyleScheme(
      regular14: regular14 ?? this.regular14,
      regular18: regular18 ?? this.regular18,
      medium12: medium12 ?? this.medium12,
      medium16: medium16 ?? this.medium16,
      medium20: medium20 ?? this.medium20,
      medium24: medium24 ?? this.medium24,
      bold20: bold20 ?? this.bold20,
      regular13: regular13 ?? this.regular13,
      regular16: regular16 ?? this.regular16,
      semiBold11: semiBold11 ?? this.semiBold11,
      semiBold16: semiBold16 ?? this.semiBold16,
      semiBold30: semiBold30 ?? this.semiBold30,
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
      bold20: TextStyle.lerp(bold20, other.bold20, t),
      regular13: TextStyle.lerp(regular13, other.regular13, t),
      regular16: TextStyle.lerp(regular16, other.regular16, t),
      semiBold11: TextStyle.lerp(semiBold11, other.semiBold11, t),
      semiBold16: TextStyle.lerp(semiBold16, other.semiBold16, t),
      semiBold30: TextStyle.lerp(semiBold30, other.semiBold30, t),
    );
  }
}
