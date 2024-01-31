import 'package:flutter/material.dart';

extension CustomColors on BuildContext {
  Color get primary => Theme.of(this).extension<CustomColorScheme>()!.primary!;
  Color get background => Theme.of(this).extension<CustomColorScheme>()!.background!;
}

@immutable
class CustomColorScheme extends ThemeExtension<CustomColorScheme> {
  final Color? primary;
  final Color? background;

  const CustomColorScheme({
    required this.primary,
    required this.background,
  });

  const CustomColorScheme.light({
    this.primary = const Color(0xffca7e44),
    this.background = const Color(0xffca7e44),
  });

  const CustomColorScheme.dark({
    this.primary = Colors.black,
    this.background = const Color(0xffca7e44),
  });

  @override
  ThemeExtension<CustomColorScheme> copyWith({
    Color? primary,
    Color? background,
  }) {
    return CustomColorScheme(
      primary: primary ?? this.primary,
      background: background ?? this.background,
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
    );
  }
}
