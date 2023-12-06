import 'package:flutter/material.dart';
import 'package:sun_switch/widgets/background_buildings.dart/background_back_buildings.dart';
import 'package:sun_switch/widgets/background_buildings.dart/background_front_buildings.dart';

class BackgroundBuildings extends StatelessWidget {
  const BackgroundBuildings({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundBackBuildingsPainter(),
      foregroundPainter: BackgroundFrontBuildingsPainter(),
      child: child,
    );
  }
}
