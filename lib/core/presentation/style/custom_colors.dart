import 'package:flutter/material.dart';

class CustomColors {
  const CustomColors.of(BuildContext context) : _context = context;
  final BuildContext _context;

  Color get primary => Theme.of(_context).extension<CustomColorScheme>()!.primary!;
}

@immutable
class CustomColorScheme extends ThemeExtension<CustomColorScheme> {
  const CustomColorScheme({required this.primary});

  const CustomColorScheme.classic({this.primary = const Color(0xFFD84E56)});

  final Color? primary;

  @override
  ThemeExtension<CustomColorScheme> copyWith({Color? primary}) {
    return CustomColorScheme(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<CustomColorScheme> lerp(ThemeExtension<CustomColorScheme>? other, double t) {
    if (other is! CustomColorScheme) {
      return this;
    }
    return CustomColorScheme(primary: Color.lerp(primary, other.primary, t));
  }
}
