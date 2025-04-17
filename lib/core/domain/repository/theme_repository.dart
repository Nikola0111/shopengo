import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';
import 'package:shopengo/core/presentation/style/custom_text_styles.dart';

class ThemeRepository {
  final _colorScheme = const CustomColorScheme.classic();
  String? _appLogoSvgUrl;

  String? get appLogoSvgUrl => _appLogoSvgUrl;

  ThemeData buildTheme() {
    final textStyleScheme = CustomTextStyleScheme.fromPrimaryTextColor(
      primaryTextColor: _colorScheme.primaryText!,
    );
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(color: _colorScheme.background),
      extensions: <ThemeExtension<dynamic>>[_colorScheme, textStyleScheme],
    );
  }
}
