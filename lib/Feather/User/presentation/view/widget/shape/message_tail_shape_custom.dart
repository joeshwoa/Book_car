import 'package:flutter/material.dart';

class MessageTailShapeCustom extends ShapeBorder {
  final double radius;
  final Color? fillColor;
  final double borderWidth;
  final Color? borderColor;
  final bool bottomLeft;
  final bool bottomRight;

  const MessageTailShapeCustom({
    required this.radius,
    this.fillColor,
    this.borderWidth = 1.0,
    this.borderColor,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect, textDirection: textDirection), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      _createPath(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (fillColor == null && borderColor == null) return;

    if (fillColor != null) {
      final fillPaint = Paint()
        ..color = fillColor! // Use the provided fillColor
        ..style = PaintingStyle.fill;
      final fillPath = getInnerPath(rect, textDirection: textDirection);
      canvas.drawPath(fillPath, fillPaint);
    }

    if (borderColor != null) {
      final borderPaint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;
      final borderPath = getOuterPath(rect, textDirection: textDirection);
      canvas.drawPath(borderPath, borderPaint);
    }
  }

  Path _createPath(Rect rect) {
    Rect insetRect = rect.deflate(borderWidth);

    Path path = Path();

    double inset = radius;

    if(bottomLeft) {
      path.moveTo(insetRect.left, insetRect.top);
      path.lineTo(insetRect.right, insetRect.top);
      path.lineTo(insetRect.right, insetRect.bottom);
      path.arcToPoint(
        Offset(insetRect.left, insetRect.top),
        radius: Radius.circular(inset),
        clockwise: false,
      );
    } else if (bottomRight) {
      path.moveTo(insetRect.right, insetRect.top);
      path.lineTo(insetRect.left, insetRect.top);
      path.lineTo(insetRect.left, insetRect.bottom);
      path.arcToPoint(
        Offset(insetRect.right, insetRect.top),
        radius: Radius.circular(inset),
        clockwise: true,
      );
    }


    // Close the path
    path.close();

    return path;
  }

  @override
  ShapeBorder scale(double t) {
    return MessageTailShapeCustom(
      radius: radius * t,
      borderWidth: borderWidth * t,
      borderColor: borderColor,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );
  }
}