import 'package:flutter/material.dart';

class BackgroundFrontBuildingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawOneBuilding(canvas, size, pos: const Offset(95, 22));
    _drawOneBuilding(canvas, size, pos: const Offset(85, 18), width: 7);
    _drawOneBuilding(canvas, size, pos: const Offset(68, 22));
    _drawOneBuilding(canvas, size, pos: const Offset(74, 20));
    _drawOneBuilding(canvas, size, pos: const Offset(56, 24));
  }

  _drawOneBuilding(
    Canvas canvas,
    Size size, {
    Offset pos = const Offset(0, 0),
    double width = 10,
    double height = 20,
  }) {
    var paint = Paint()
      ..color = const Color(0xFF31384B)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..addRect(
        Rect.fromLTWH(
          pos.dx,
          pos.dy,
          width,
          height,
        ),
      )
      ..close();

    canvas.drawPath(path, paint);

    _drawWindow(
      startingPos: pos,
      canvas: canvas,
      buildingSize: Size(width, height),
      windowWidth: 1,
      windowHeight: 1,
      gap: 2,
    );
  }

  _drawWindow({
    required Offset startingPos,
    required Canvas canvas,
    required Size buildingSize,
    required double windowWidth,
    required double windowHeight,
    required double gap,
  }) {
    final verticalWindowCount = buildingSize.height ~/ (windowHeight + gap);
    final horizontalWindowCount = buildingSize.width ~/ (windowWidth + gap);

    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = windowWidth;

    final startingX = startingPos.dx + gap;
    final startingY = startingPos.dy + gap;
    final path = Path();

    for (var i = 0; i < verticalWindowCount; i++) {
      for (var j = 0; j < horizontalWindowCount; j++) {
        path.moveTo(
          startingX + j * (windowWidth + gap),
          startingY + i * (windowHeight + gap),
        );
        path.relativeLineTo(0, windowHeight);
      }
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
