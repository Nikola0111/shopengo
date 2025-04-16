import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';

class ThemeRepository {
  final _colorScheme = CustomColorScheme.classic();
  String? _appLogoSvgUrl;

  String? get appLogoSvgUrl => _appLogoSvgUrl;

  ThemeData buildTheme() {
    final textStyleScheme = CustomTextStyleScheme.fromPrimaryTextColor(primaryTextColor: _colorScheme.primary!);
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(color: _colorScheme.primary),
      extensions: <ThemeExtension<dynamic>>[_colorScheme, textStyleScheme],
    );
  }
}
