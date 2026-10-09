import 'package:flutter/material.dart';

class CustomColors {
  const new of(BuildContext context) : _context = context;
  final BuildContext _context;

  Color get primary => Theme.of(_context).extension<CustomColorScheme>()!.primary!;
  Color get background => Theme.of(_context).extension<CustomColorScheme>()!.background!;
  Color get primaryText => Theme.of(_context).extension<CustomColorScheme>()!.primaryText!;
  Color get secondaryText => Theme.of(_context).extension<CustomColorScheme>()!.secondaryText!;
  Color get cancel => Theme.of(_context).extension<CustomColorScheme>()!.cancel!;
  Color get confirm => Theme.of(_context).extension<CustomColorScheme>()!.confirm!;
  Color get storeCardGradientStart => Theme.of(_context).extension<CustomColorScheme>()!.storeCardGradientStart!;
  Color get storeCardGradientEnd => Theme.of(_context).extension<CustomColorScheme>()!.storeCardGradientEnd!;
  Color get undoColor => Theme.of(_context).extension<CustomColorScheme>()!.undoColor!;
  Color get surface => Theme.of(_context).extension<CustomColorScheme>()!.surface!;
  Color get dark => Theme.of(_context).extension<CustomColorScheme>()!.dark!;
  Color get border => Theme.of(_context).extension<CustomColorScheme>()!.border!;
  Color get hintText => Theme.of(_context).extension<CustomColorScheme>()!.hintText!;
  Color get badgeBackground => Theme.of(_context).extension<CustomColorScheme>()!.badgeBackground!;
}

@immutable
class CustomColorScheme extends ThemeExtension<CustomColorScheme> {
  const new({
    required this.primary,
    required this.background,
    required this.primaryText,
    required this.secondaryText,
    required this.cancel,
    required this.confirm,
    required this.storeCardGradientStart,
    required this.storeCardGradientEnd,
    required this.undoColor,
    required this.surface,
    required this.dark,
    required this.border,
    required this.hintText,
    required this.badgeBackground,
  });

  const new classic({
    this.primary = const Color(0xFF6A5AE0),
    this.background = const Color(0xFFFFFFFF),
    this.primaryText = const Color(0xFFFFFFFF),
    this.secondaryText = Colors.black,
    this.cancel = Colors.red,
    this.confirm = const Color(0xFF16A34A),
    this.storeCardGradientStart = const Color(0xFF9A8FFF),
    this.storeCardGradientEnd = const Color(0xFF847BD9),
    this.undoColor = Colors.grey,
    this.surface = const Color(0xFFF7F6FC),
    this.dark = const Color(0xFF1D1A2E),
    this.border = const Color(0xFFE4E1F2),
    this.hintText = const Color(0xFFA9A4C4),
    this.badgeBackground = const Color(0x6123186E),
  });

  final Color? primary;
  final Color? background;
  final Color? primaryText;
  final Color? secondaryText;
  final Color? cancel;
  final Color? confirm;
  final Color? storeCardGradientStart;
  final Color? storeCardGradientEnd;
  final Color? undoColor;
  final Color? surface;
  final Color? dark;
  final Color? border;
  final Color? hintText;
  final Color? badgeBackground;

  @override
  ThemeExtension<CustomColorScheme> copyWith({
    Color? primary,
    Color? background,
    Color? primaryText,
    Color? secondaryText,
    Color? cancel,
    Color? confirm,
    Color? storeCardGradientStart,
    Color? storeCardGradientEnd,
    Color? undoColor,
    Color? surface,
    Color? dark,
    Color? border,
    Color? hintText,
    Color? badgeBackground,
  }) {
    return CustomColorScheme(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      cancel: cancel ?? this.cancel,
      confirm: confirm ?? this.confirm,
      storeCardGradientStart: storeCardGradientStart ?? this.storeCardGradientStart,
      storeCardGradientEnd: storeCardGradientEnd ?? this.storeCardGradientEnd,
      undoColor: undoColor ?? this.undoColor,
      surface: surface ?? this.surface,
      dark: dark ?? this.dark,
      border: border ?? this.border,
      hintText: hintText ?? this.hintText,
      badgeBackground: badgeBackground ?? this.badgeBackground,
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
      storeCardGradientStart: Color.lerp(storeCardGradientStart, other.storeCardGradientStart, t),
      storeCardGradientEnd: Color.lerp(storeCardGradientEnd, other.storeCardGradientEnd, t),
      undoColor: Color.lerp(undoColor, other.undoColor, t),
      surface: Color.lerp(surface, other.surface, t),
      dark: Color.lerp(dark, other.dark, t),
      border: Color.lerp(border, other.border, t),
      hintText: Color.lerp(hintText, other.hintText, t),
      badgeBackground: Color.lerp(badgeBackground, other.badgeBackground, t),
    );
  }
}
