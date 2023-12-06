import 'package:flutter/material.dart';

class BackgroundBackBuildingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3381CC)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    const rx = 2.7;
    const ry = 2.0;

    final path = Path()
      ..moveTo(0, h)
      ..relativeLineTo(0, h * -0.4)
      ..relativeLineTo(rx, 0)
      ..relativeLineTo(0, ry)
      ..relativeLineTo(rx, 0)
      ..relativeLineTo(0, -ry)
      ..relativeLineTo(rx * 2, 0)
      ..relativeLineTo(0, ry)
      ..relativeLineTo(rx, 0)
      ..relativeLineTo(rx * .5, -ry)
      ..relativeLineTo(0, -rx)
      ..relativeLineTo(rx * 2, 0)
      ..relativeLineTo(0, ry * 3)
      ..relativeLineTo(rx * 2, 0)
      ..relativeLineTo(0, -ry * 1.5)
      ..relativeLineTo(rx, 0)
      ..relativeLineTo(0, ry * 3.5)
      ..relativeLineTo(rx * 1.5, 0)
      ..relativeLineTo(0, ry * 6)
      ..relativeLineTo(rx * 1, 0)
      ..relativeLineTo(0, -ry * 8)
      ..relativeLineTo(rx * 1.5, 0)
      ..relativeLineTo(0, ry * 6)
      ..relativeLineTo(rx * 0.3, 0)
      ..relativeLineTo(0, -ry * 9)
      ..relativeLineTo(rx, 0)
      ..relativeLineTo(0, ry * 9) // end of thin building
      ..relativeLineTo(rx * 2, 0)
      ..relativeLineTo(0, -ry * 7)
      ..relativeLineTo(rx * 2, 0)
      ..relativeLineTo(0, ry * 2)
      ..relativeLineTo(rx * 1.5, 0)
      ..relativeLineTo(0, ry * 8)
      ..relativeLineTo(rx, 0)
      ..relativeLineTo(0, -ry * 10)
      ..relativeLineTo(rx * 2.5, 0)
      ..relativeLineTo(0, -ry * 2)
      ..relativeLineTo(rx, 0)
      ..relativeLineTo(0, ry * 8)
      ..relativeLineTo(rx * 1.5, 0)
      ..relativeLineTo(0, -ry * 9)
      ..relativeLineTo(rx * 3, 0)
      ..relativeLineTo(0, ry * 2)
      ..relativeLineTo(rx * 2, 0)
      ..relativeLineTo(0, -ry * 2)
      ..relativeLineTo(rx, 0)
      ..relativeLineTo(0, -ry * 2)
      ..relativeLineTo(rx * 2.5, 0)
      ..relativeLineTo(0, ry * 2)
      ..relativeLineTo(rx * 2, 0)
      ..relativeLineTo(0, -ry)
      ..relativeLineTo(rx * 3, 0)

      // close
      ..relativeLineTo(0, h)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
