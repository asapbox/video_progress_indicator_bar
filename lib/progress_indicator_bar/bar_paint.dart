import 'package:flutter/material.dart';
import 'bar_painter.dart';

class BarPaint extends StatelessWidget {
  /// The height of the bar.
  final double barHeight;

  /// The total width of the bar.
  final double barLength;

  /// The shape of the left and right ends of the bar.
  final StrokeCap barEndShape;

  /// The current position of the progress bar.
  final double currentProgressValue;

  /// The color of the bar which is underneath of the progress indication and
  /// the thumb.
  final Color barBackgroundColor;

  /// The current progress indication color.
  final Color barProgressColor;

  /// The color of the thumb (more understandable is to call it a handle radius
  /// or a knob radius which is been used for dragging, but in the Flutter doc
  /// it is called a thumb).
  final Color thumbColor;

  /// The radius of the thumb (more understandable is to call it a handle radius
  /// or a knob radius which is been used for dragging, but in the Flutter doc
  /// it is called a thumb).
  final double thumbRadius;

  /// Sending a tap position after first tap on the bar. Which can be used for
  /// moving the thumb to a tapped position within the bar
  final ValueChanged<double>? onTap;

  ///
  final ValueChanged<double>? onDragStart;

  /// Sending the current position of the progress, when dragging the thumb.
  final ValueChanged<double>? onDragUpdate;

  ///
  final VoidCallback? onDragEnd;

  const BarPaint({
    Key? key,
    required this.barHeight,
    required this.currentProgressValue,
    required this.barProgressColor,
    required this.barEndShape,
    required this.barLength,
    required this.barBackgroundColor,
    required this.thumbRadius,
    required this.thumbColor,
    this.onTap,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: barHeight,
      width: barLength,
      child: GestureDetector(
        onHorizontalDragDown: (DragDownDetails dragDownDetails) {
          double dragTapValue = dragDownDetails.localPosition.dx;
          if (0 < dragTapValue && dragTapValue <= thumbRadius *2) {
            onTap!(dragTapValue);
          } else if (thumbRadius *2 < dragTapValue &&
              dragTapValue <= (barLength - thumbRadius *2)) {
            onTap!(dragTapValue - thumbRadius);
          } else if (dragTapValue < barLength) {
            onTap!(dragTapValue - thumbRadius *2);
          }

          debugPrint('dragDownDetails ${dragDownDetails.localPosition.dx}');
        },
        onHorizontalDragStart: (DragStartDetails dragStartDetails) {
          double dragStartValue = dragStartDetails.localPosition.dx;

          onDragStart!(dragStartValue);

          debugPrint('dragStartValue ${dragStartDetails.localPosition.dx}');
        },
        onHorizontalDragUpdate: (DragUpdateDetails dragUpdateDetails) {
          double dragUpdateValue = dragUpdateDetails.localPosition.dx;
          // When drag the thumb the current position is sending as an argument
          // to the onDragUpdate method.
          if (0 < dragUpdateValue &&
              dragUpdateValue < (barLength - barHeight)) {
            onDragUpdate!(dragUpdateValue);
          }

          debugPrint('The thumb and current progress are on position '
              '= ${dragUpdateDetails.localPosition.dx}');
        },
        onHorizontalDragEnd: (DragEndDetails dragEndDetails) {
          onDragEnd!();
        },
        child: CustomPaint(
          painter: BarPainter(
            barHeight: barHeight,
            barColor: barBackgroundColor,
            barProgressColor: barProgressColor,
            barLength: barLength,
            barEndShape: barEndShape,
            currentProgressValue: currentProgressValue,
            thumbColor: thumbColor,
            thumbRadius: thumbRadius,
          ),
          child: const SizedBox(),
        ),
      ),
    );
  }
}
