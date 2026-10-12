import 'package:basketwise/core/presentation/style/custom_colors.dart';
import 'package:flutter/material.dart';

class SheetDragHandle extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(color: CustomColors.of(context).sheetHandle, borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}
