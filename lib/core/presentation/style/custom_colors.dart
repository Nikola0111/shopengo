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
  Color get divider => Theme.of(_context).extension<CustomColorScheme>()!.divider!;
  Color get accentText => Theme.of(_context).extension<CustomColorScheme>()!.accentText!;
  Color get mutedText => Theme.of(_context).extension<CustomColorScheme>()!.mutedText!;
  Color get sectionLabel => Theme.of(_context).extension<CustomColorScheme>()!.sectionLabel!;
  Color get sheetHandle => Theme.of(_context).extension<CustomColorScheme>()!.sheetHandle!;
  Color get outline => Theme.of(_context).extension<CustomColorScheme>()!.outline!;
  Color get highlight => Theme.of(_context).extension<CustomColorScheme>()!.highlight!;
  Color get scrim => Theme.of(_context).extension<CustomColorScheme>()!.scrim!;
  Color get fill => Theme.of(_context).extension<CustomColorScheme>()!.fill!;
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
    required this.divider,
    required this.accentText,
    required this.mutedText,
    required this.sectionLabel,
    required this.sheetHandle,
    required this.outline,
    required this.highlight,
    required this.scrim,
    required this.fill,
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
    this.divider = const Color(0xFFECEAF6),
    this.accentText = const Color(0xFF5646D0),
    this.mutedText = const Color(0xFF8C87AE),
    this.sectionLabel = const Color(0xFF7B76A0),
    this.sheetHandle = const Color(0xFFD8D4EA),
    this.outline = const Color(0xFFD8D2F6),
    this.highlight = const Color(0xFFEEEBFD),
    this.scrim = const Color(0x73140E3C),
    this.fill = const Color(0xFFF3F1FB),
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
  final Color? divider;
  final Color? accentText;
  final Color? mutedText;
  final Color? sectionLabel;
  final Color? sheetHandle;
  final Color? outline;
  final Color? highlight;
  final Color? scrim;
  final Color? fill;

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
    Color? divider,
    Color? accentText,
    Color? mutedText,
    Color? sectionLabel,
    Color? sheetHandle,
    Color? outline,
    Color? highlight,
    Color? scrim,
    Color? fill,
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
      divider: divider ?? this.divider,
      accentText: accentText ?? this.accentText,
      mutedText: mutedText ?? this.mutedText,
      sectionLabel: sectionLabel ?? this.sectionLabel,
      sheetHandle: sheetHandle ?? this.sheetHandle,
      outline: outline ?? this.outline,
      highlight: highlight ?? this.highlight,
      scrim: scrim ?? this.scrim,
      fill: fill ?? this.fill,
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
      divider: Color.lerp(divider, other.divider, t),
      accentText: Color.lerp(accentText, other.accentText, t),
      mutedText: Color.lerp(mutedText, other.mutedText, t),
      sectionLabel: Color.lerp(sectionLabel, other.sectionLabel, t),
      sheetHandle: Color.lerp(sheetHandle, other.sheetHandle, t),
      outline: Color.lerp(outline, other.outline, t),
      highlight: Color.lerp(highlight, other.highlight, t),
      scrim: Color.lerp(scrim, other.scrim, t),
      fill: Color.lerp(fill, other.fill, t),
    );
  }
}
