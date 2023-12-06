import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sun_switch/widgets/moving_sun.dart';

enum SunExpression {
  neutral(0.0, Offset.zero),
  angry(0.2, Offset(0.275, 0.0)),
  kindaAngry(0.4, Offset(0.1, -0.1)),
  kindaSad(0.6, Offset(-0.1, -0.15)),
  sad(0.8, Offset(-0.2, -0.2)),
  neutralBack(1, Offset.zero);

  const SunExpression(
    this.startAt,
    this.position,
  );

  final double startAt;
  final Offset position;
}

class SunFace extends StatefulWidget {
  const SunFace({
    super.key,
    required this.face,
    required this.side,
  });

  final SunExpression face;
  final SunSide side;

  @override
  State<SunFace> createState() => _SunFaceState();
}

class _SunFaceState extends State<SunFace> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this);

  bool _isRunning = false;
  Duration get _transitionDuration => _isRunning
      ? const Duration(seconds: 1)
      : const Duration(milliseconds: 400);

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(SunFace oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.face != widget.face) {
      _isRunning = oldWidget.side != widget.side;

      final wasSad = oldWidget.face == SunExpression.sad;
      final isNeutral = widget.face == SunExpression.neutral;
      final isSadToNeutral = wasSad && isNeutral;
      final animateToFace =
          isSadToNeutral ? SunExpression.neutralBack : widget.face;

      _animationController
          .animateTo(
            animateToFace.startAt,
            duration: _transitionDuration,
            curve: _isRunning ? Curves.easeInOutBack : Curves.easeInOutBack,
          )
          .whenComplete(
            () => _resetAnimation(isSadToNeutral),
          );
    }
  }

  _resetAnimation(bool needReset) {
    if (needReset) {
      _animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('isRunning: $_isRunning');

    return Column(
      children: [
        AnimatedSlide(
          duration: _transitionDuration,
          curve: _isRunning ? Curves.easeInBack : Curves.easeInOutBack,
          offset: widget.face.position,
          child: Transform(
            transform: Matrix4.identity()..scale(0.5),
            alignment: Alignment.center,
            child: Lottie.asset(
              'assets/lotties/sun_faces.json',
              controller: _animationController,
            ),
          ),
        ),
      ],
    );
  }
}
