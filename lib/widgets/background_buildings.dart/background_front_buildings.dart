import 'package:flutter/material.dart';
import 'package:sun_switch/widgets/constants/sun_colors.dart';

class BackgroundFrontBuildingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Offset buildingPos1 = const Offset(145, 31);
    Offset buildingPos2 = const Offset(135, 27);
    Offset buildingPos3 = const Offset(118, 31);
    Offset buildingPos4 = const Offset(124, 29);
    Offset buildingPos5 = const Offset(106, 33);

    _drawOneBuilding(canvas, size, pos: buildingPos1);
    _drawOneBuilding(canvas, size, pos: buildingPos2, width: 7);
    _drawOneBuilding(canvas, size, pos: buildingPos3);
    _drawOneBuilding(canvas, size, pos: buildingPos4);
    _drawOneBuilding(canvas, size, pos: buildingPos5);
  }

  _drawOneBuilding(
    Canvas canvas,
    Size size, {
    Offset pos = const Offset(0, 0),
    double width = 10,
    double height = 20,
  }) {
    var paint = Paint()
      ..color = SunColors.shadow
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
      ..color = SunColors.window
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
