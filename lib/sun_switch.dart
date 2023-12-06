import 'package:flutter/material.dart';
import 'package:sun_switch/background_back_buildings.dart';
import 'package:sun_switch/background_front_buildings.dart';
import 'package:sun_switch/sun_faces.dart';

class SunSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SunSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  State<SunSwitch> createState() => _SunSwitchState();
}

class _SunSwitchState extends State<SunSwitch> {
  FaceExpression _sunFace = FaceExpression.neutral;
  bool _enabled = true;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.value ? 'ON' : 'OFF'),
        Text(_isHovered ? 'Hovered' : 'Not hovered'),
        Text(_enabled ? 'Enabled' : 'Disabled'),
        Text(_sunFace.name),
        InkWell(
          onTap: () {
            if (!_enabled) return;

            widget.onChanged?.call(!widget.value);
            setState(() {
              _enabled = false;

              if (widget.value) {
                _sunFace = FaceExpression.neutral;
              } else {
                _sunFace = FaceExpression.kindaAngry;
              }
            });
          },
          onHover: (value) {
            setState(() {
              _isHovered = value;
            });
            if (!_enabled) return;

            setState(() {
              if (value) {
                if (widget.value) {
                  _sunFace = FaceExpression.sad;
                } else {
                  _sunFace = FaceExpression.angry;
                }
              } else {
                if (widget.value) {
                  _sunFace = FaceExpression.kindaSad;
                } else {
                  _sunFace = FaceExpression.neutral;
                }
              }
            });
          },
          child: Container(
            width: 150,
            height: 60,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFF3C97F4),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomPaint(
                  painter: BackgroundBackBuildingsPainter(),
                  child: const SizedBox(
                    width: 150,
                    height: 60,
                  ),
                ),
                AnimatedAlign(
                  onEnd: () {
                    setState(() {
                      _enabled = true;
                      if (widget.value) {
                        if (_isHovered) {
                          _sunFace = FaceExpression.sad;
                        } else {
                          _sunFace = FaceExpression.kindaSad;
                        }
                      } else {
                        if (_isHovered) {
                          _sunFace = FaceExpression.angry;
                        } else {
                          _sunFace = FaceExpression.neutral;
                        }
                      }
                    });
                  },
                  duration: const Duration(milliseconds: 1800),
                  curve: const ElasticInOutCurve(0.6),
                  alignment: widget.value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    width: 56,
                    height: 56,
                    margin: const EdgeInsets.only(
                      left: 2,
                      right: 10,
                      bottom: 2,
                      top: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDE25C),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    alignment: Alignment.center,
                    child: SunFaces(
                      face: _sunFace,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomPaint(
                    painter: BackgroundFrontBuildingsPainter(),
                    child: const SizedBox(
                      width: 100,
                      height: 50,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  color: const Color(0xFF31384B),
                  height: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Sun extends StatelessWidget {
  const Sun({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      margin: const EdgeInsets.only(
        left: 2,
        right: 10,
        bottom: 2,
        top: 2,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFDE25C),
        borderRadius: BorderRadius.circular(35),
      ),
      alignment: Alignment.center,
      child: const SunFaces(
        face: FaceExpression.neutral,
      ),
    );
  }
}
