import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopengo/extensions/custom_colors.dart';
import 'package:shopengo/extensions/custom_text_styles.dart';
import 'package:shopengo/mixins/logger_mixin.dart';
import 'package:shopengo/mixins/subscription_mixin.dart';

enum AppThemeMode {
  light('light'),
  dark('dark');

  final String value;

  const AppThemeMode(this.value);

  factory AppThemeMode.from(String value) {
    if (value == light.name) {
      return AppThemeMode.light;
    }
    if (value == dark.value) {
      return AppThemeMode.dark;
    }
    throw ('theme not found for string: $value');
  }
}

enum AppearanceEvent { themeChanged }

class AppearanceService with SubscriptionMixin<AppearanceEvent>, LoggerMixin {
  AppThemeMode _appTheme = AppThemeMode.light;
  AppThemeMode get appTheme => _appTheme;
  Color? _customColor;

  Color? get customColor => _customColor;

  ThemeData buildTheme({AppThemeMode? appThemeMode}) {
    final ThemeData theme;

    _appTheme = appThemeMode ?? _extractTheme();

    switch (appThemeMode ?? _appTheme) {
      case AppThemeMode.light:
        const colorScheme = CustomColorScheme.light();
        final textStyleScheme = CustomTextStyleScheme.fromPrimaryTextColor(primaryTextColor: colorScheme.primary!);
        theme = ThemeData(
          brightness: Brightness.light,
          extensions: <ThemeExtension<dynamic>>[colorScheme, textStyleScheme],
          appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: colorScheme.background!)),
        );
        break;
      case AppThemeMode.dark:
        const colorScheme = CustomColorScheme.dark();
        final textStyleScheme = CustomTextStyleScheme.fromPrimaryTextColor(primaryTextColor: colorScheme.primary!);
        theme = ThemeData(
          brightness: Brightness.dark,
          extensions: <ThemeExtension<dynamic>>[colorScheme, textStyleScheme],
          appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: colorScheme.background!)),
        );
        break;
    }

    return theme;
  }

  AppThemeMode _extractTheme() {
    final brightness = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).platformBrightness;
    final themeMode = brightness == Brightness.light ? AppThemeMode.light : AppThemeMode.dark;
    return themeMode;
  }

  Future<void> switchTheme(AppThemeMode newTheme) async {
    if (_appTheme == newTheme) return;
    _appTheme = newTheme;
    logI('switch theme to: ${_appTheme.value}');
    sendEvent(AppearanceEvent.themeChanged, params: [newTheme]);
  }

  @override
  String get className => 'AppearanceService';
}
