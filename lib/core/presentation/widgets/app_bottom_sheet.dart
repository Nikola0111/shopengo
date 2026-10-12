import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:flutter/material.dart';

abstract final class AppBottomSheet {
  /// Space a full height sheet leaves above itself, below the status bar.
  static const double fullHeightTopGap = 16;

  static const double _radius = 28;

  /// Modal bottom sheet with the app's surface color, scrim and rounded top corners.
  static Future<T?> show<T>(BuildContext context, {required WidgetBuilder builder}) {
    final colors = CustomColors.of(context);
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: colors.surface,
      barrierColor: colors.scrim,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(_radius))),
      builder: builder,
    );
  }
}
