import 'package:flutter/material.dart';

class BarPainter extends CustomPainter {
  /// Bar properties
  final double barHeight;
  final double barLength;
  final Color barColor;
  final Color barProgressColor;
  final StrokeCap barEndShape;
  final double currentProgressValue;

  //  final double thumbCurrentPosition;
  final double thumbRadius;
  final Color thumbColor;

  BarPainter({
    required this.thumbRadius,
    required this.thumbColor,
    required this.barHeight,
    required this.barColor,
    required this.barProgressColor,
    required this.barLength,
    required this.barEndShape,
    required this.currentProgressValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Bar layout
    canvas.drawLine(
        Offset(
          barHeight / 2,
          barHeight / 2,
        ),
        Offset(
          barLength - barHeight / 2,
          barHeight / 2,
        ),
        Paint()
          ..color = barColor
          ..strokeWidth = barHeight
          ..strokeCap = barEndShape);

    // Progress indication
    canvas.drawLine(
        Offset(
          barHeight / 2, // X axis beginning
          barHeight / 2, // Y axis beginning
        ),
        Offset(
          barHeight / 2 + currentProgressValue, // X axis ending
          barHeight / 2, // Y axis ending
        ),
        Paint()
          ..color = barProgressColor
          ..strokeWidth = barHeight
          ..strokeCap = barEndShape);

    // Bar thumb, more understandable is to call it a handle or a knob.
    canvas.drawCircle(
      Offset(
        barHeight / 2 + currentProgressValue,
        barHeight / 2,
      ),
      thumbRadius,
      Paint()
        ..style = PaintingStyle.fill
        ..color = thumbColor,
    );
  }

  @override
  bool shouldRepaint(covariant BarPainter oldDelegate) {
    if (currentProgressValue != oldDelegate.currentProgressValue) {
      return true;
    } else {
      return false;
    }
  }
}
