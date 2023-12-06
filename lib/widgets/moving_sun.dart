import 'package:flutter/material.dart';
import 'package:sun_switch/widgets/constants/sun_colors.dart';
import 'package:sun_switch/widgets/sun_face.dart';

enum SunSide {
  left,
  right,
}

class MovingSun extends AnimatedAlign {
  MovingSun({
    super.key,
    required SunSide side,
    required super.onEnd,
    required SunExpression expression,
  }) : super(
          alignment: side == SunSide.left
              ? Alignment.centerLeft
              : Alignment.centerRight,
          duration: const Duration(milliseconds: 1800),
          curve: const ElasticInOutCurve(0.6),
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
              color: SunColors.sunSkin,
              borderRadius: BorderRadius.circular(35),
            ),
            alignment: Alignment.center,
            child: SunFace(
              face: expression,
              side: side,
            ),
          ),
        );
}
