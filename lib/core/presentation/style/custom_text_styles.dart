import 'package:flutter/material.dart';

class CustomTextStyles {
  const CustomTextStyles.of(BuildContext context) : _context = context;
  final BuildContext _context;

  TextStyle get regular18 => Theme.of(_context).extension<CustomTextStyleScheme>()!.regular18!;
}

@immutable
class CustomTextStyleScheme extends ThemeExtension<CustomTextStyleScheme> {
  const CustomTextStyleScheme({required this.regular18});

  factory CustomTextStyleScheme.fromPrimaryTextColor({required Color primaryTextColor}) {
    return CustomTextStyleScheme(
      regular18: TextStyle(
        color: primaryTextColor,
        fontSize: 18,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w400,
        height: 1.2,
      ),
    );
  }

  final TextStyle? regular18;

  @override
  CustomTextStyleScheme copyWith({TextStyle? regular18}) {
    return CustomTextStyleScheme(regular18: regular18 ?? this.regular18);
  }

  @override
  CustomTextStyleScheme lerp(ThemeExtension<CustomTextStyleScheme>? other, double t) {
    if (other is! CustomTextStyleScheme) {
      return this;
    }
    return CustomTextStyleScheme(regular18: TextStyle.lerp(regular18, other.regular18, t));
  }
}
