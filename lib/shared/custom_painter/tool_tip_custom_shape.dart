import 'package:flutter/material.dart';

class ToolTipCustomShape extends ShapeBorder {
  final bool usePadding;
  final int index;

  const ToolTipCustomShape({this.usePadding = true, required this.index});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(
      rect.topLeft,
      rect.bottomRight - const Offset(0, 20),
    );

    if (index == 6) {
      return Path()
        ..addRRect(
            RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 8)))
        ..moveTo(rect.bottomCenter.dx + 14, rect.bottomCenter.dy)
        ..relativeLineTo(10, 7.5)
        ..relativeLineTo(10, -7.5)
        ..close();
    }

    return Path()
      ..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 8)))
      ..moveTo(rect.bottomCenter.dx - 10, rect.bottomCenter.dy)
      ..relativeLineTo(10, 7.5)
      ..relativeLineTo(10, -7.5)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
