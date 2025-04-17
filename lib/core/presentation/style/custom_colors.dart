import 'package:flutter/material.dart';

class CustomColors {
  const CustomColors.of(BuildContext context) : _context = context;
  final BuildContext _context;

  Color get primary => Theme.of(_context).extension<CustomColorScheme>()!.primary!;
  Color get background => Theme.of(_context).extension<CustomColorScheme>()!.background!;
  Color get primaryText => Theme.of(_context).extension<CustomColorScheme>()!.primaryText!;
}

@immutable
class CustomColorScheme extends ThemeExtension<CustomColorScheme> {
  const CustomColorScheme({required this.primary, required this.background, required this.primaryText});

  const CustomColorScheme.classic({
    this.primary = const Color(0xFFD84E56),
    this.background = const Color(0xFFFFFFFF),
    this.primaryText = Colors.grey,
  });

  final Color? primary;
  final Color? background;
  final Color? primaryText;

  @override
  ThemeExtension<CustomColorScheme> copyWith({Color? primary, Color? background, Color? primaryText}) {
    return CustomColorScheme(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      primaryText: primaryText ?? this.primaryText,
    );
  }

  @override
  ThemeExtension<CustomColorScheme> lerp(ThemeExtension<CustomColorScheme>? other, double t) {
    if (other is! CustomColorScheme) {
      return this;
    }
    return CustomColorScheme(
      primary: Color.lerp(primary, other.primary, t),
      background: Color.lerp(background, other.background, t),
      primaryText: Color.lerp(primaryText, other.primaryText, t),
    );
  }
}
