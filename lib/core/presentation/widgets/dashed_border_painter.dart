import 'package:flutter/material.dart';

/// Paints a dashed rounded-rectangle outline around its child.
class DashedBorderPainter extends CustomPainter {
  const new({required this.color, required this.radius, this.strokeWidth = 1.5});

  final Color color;
  final double radius;
  final double strokeWidth;

  static const double _dashLength = 5;
  static const double _gapLength = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(strokeWidth / 2);
    final path = Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (final metric in path.computeMetrics()) {
      for (double start = 0; start < metric.length; start += _dashLength + _gapLength) {
        canvas.drawPath(metric.extractPath(start, start + _dashLength), paint);
      }
    }
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color || radius != oldDelegate.radius || strokeWidth != oldDelegate.strokeWidth;
}
