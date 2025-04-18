import 'package:flutter/material.dart';

class CustomColors {
  const CustomColors.of(BuildContext context) : _context = context;
  final BuildContext _context;

  Color get primary => Theme.of(_context).extension<CustomColorScheme>()!.primary!;
  Color get background => Theme.of(_context).extension<CustomColorScheme>()!.background!;
  Color get primaryText => Theme.of(_context).extension<CustomColorScheme>()!.primaryText!;
  Color get secondaryText => Theme.of(_context).extension<CustomColorScheme>()!.secondaryText!;
  Color get cancel => Theme.of(_context).extension<CustomColorScheme>()!.cancel!;
  Color get confirm => Theme.of(_context).extension<CustomColorScheme>()!.confirm!;
}

@immutable
class CustomColorScheme extends ThemeExtension<CustomColorScheme> {
  const CustomColorScheme({
    required this.primary,
    required this.background,
    required this.primaryText,
    required this.secondaryText,
    required this.cancel,
    required this.confirm,
  });

  const CustomColorScheme.classic({
    this.primary = const Color(0xFF6A5AE0),
    this.background = const Color(0xFFFFFFFF),
    this.primaryText = const Color(0xFFFFFFFF),
    this.secondaryText = Colors.black,
    this.cancel = Colors.red,
    this.confirm = const Color(0xFF16A34A),
  });

  final Color? primary;
  final Color? background;
  final Color? primaryText;
  final Color? secondaryText;
  final Color? cancel;
  final Color? confirm;

  @override
  ThemeExtension<CustomColorScheme> copyWith({
    Color? primary,
    Color? background,
    Color? primaryText,
    Color? secondaryText,
    Color? cancel,
    Color? confirm,
  }) {
    return CustomColorScheme(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      cancel: cancel ?? this.cancel,
      confirm: confirm ?? this.confirm,
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
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t),
      cancel: Color.lerp(cancel, other.cancel, t),
      confirm: Color.lerp(confirm, other.confirm, t),
    );
  }
}
