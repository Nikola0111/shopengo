import 'package:flutter/material.dart';
import 'package:shopengo/core/presentation/style/custom_colors.dart';

const double _sheetRadius = 28;

/// Space a full height sheet leaves above itself, below the status bar.
const double fullHeightSheetTopGap = 16;

/// Modal bottom sheet with the app's surface color, scrim and rounded top corners.
Future<T?> showAppBottomSheet<T>(BuildContext context, {required WidgetBuilder builder}) {
  final colors = CustomColors.of(context);
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: colors.surface,
    barrierColor: colors.scrim,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(_sheetRadius))),
    builder: builder,
  );
}
