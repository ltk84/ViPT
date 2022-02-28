import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyCustomTimerPainter extends CustomPainter {
  MyCustomTimerPainter(
      {this.animation,
      this.fillColor,
      this.fillGradient,
      this.ringColor,
      this.ringGradient,
      this.strokeWidth,
      this.strokeCap,
      this.backgroundColor,
      this.backgroundGradient})
      : super(repaint: animation);

  final Animation<double>? animation;
  final Color? fillColor, ringColor, backgroundColor;
  final double? strokeWidth;
  final StrokeCap? strokeCap;
  final Gradient? fillGradient, ringGradient, backgroundGradient;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ringColor!
      ..strokeWidth = strokeWidth!
      ..strokeCap = strokeCap!
      ..style = PaintingStyle.stroke;

    Paint anotherPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = strokeCap!
      ..style = PaintingStyle.fill;

    if (backgroundColor != null || backgroundGradient != null) {
      final backgroundPaint = Paint();

      if (backgroundGradient != null) {
        final rect = Rect.fromCircle(
            center: size.center(Offset.zero), radius: size.width / 2.2);
        backgroundPaint.shader = backgroundGradient!.createShader(rect);
      } else {
        backgroundPaint.color = backgroundColor!;
      }
      canvas.drawCircle(
          size.center(Offset.zero), size.width / 2.2, backgroundPaint);
    }

    if (ringGradient != null) {
      final rect = Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width / 2);
      paint.shader = ringGradient!.createShader(rect);
    } else {
      paint.shader = null;
    }

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
    double progress = (animation!.value) * 2 * math.pi;

    if (fillGradient != null) {
      final rect = Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width / 2);
      paint.shader = fillGradient!.createShader(rect);
    } else {
      paint.shader = null;
      paint.color = fillColor!;
    }

    canvas.drawArc(Offset.zero & size, math.pi * 1.5, progress, false, paint);

    var center = Offset(size.width / 2, size.height / 2);

    Offset endHandler =
        radiansToCoordinates(center, -math.pi / 2 + progress, size.width / 2);
    canvas.drawCircle(endHandler, 12, anotherPaint);
  }

  @override
  bool shouldRepaint(MyCustomTimerPainter old) {
    return animation!.value != old.animation!.value ||
        ringColor != old.ringColor ||
        fillColor != old.fillColor;
  }

  radiansToCoordinates(Offset center, double radians, double radius) {
    var dx = center.dx + radius * cos(radians);
    var dy = center.dy + radius * sin(radians);
    return Offset(dx, dy);
  }
}
