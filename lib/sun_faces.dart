import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum FaceExpression {
  neutral(0.0),
  angry(0.2),
  kindaAngry(0.4),
  kindaSad(0.6),
  sad(0.8),
  neutralBack(1);

  final double startingFrame;

  const FaceExpression(this.startingFrame);
}

class SunFaces extends StatefulWidget {
  const SunFaces({
    super.key,
    required this.face,
  });

  final FaceExpression face;

  @override
  State<SunFaces> createState() => _SunFacesState();
}

class _SunFacesState extends State<SunFaces>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void didUpdateWidget(SunFaces oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.face != widget.face) {
      final bool willBackToNeutral = oldWidget.face == FaceExpression.sad &&
          widget.face == FaceExpression.neutral;

      final bool isGoingOn = oldWidget.face == FaceExpression.sad &&
          widget.face == FaceExpression.neutral;
      final isGoingOff = oldWidget.face == FaceExpression.angry &&
          widget.face == FaceExpression.kindaAngry;

      setState(() {
        _isRunning = isGoingOn || isGoingOff;
      });

      _animationController
          .animateTo(
        willBackToNeutral
            ? FaceExpression.neutralBack.startingFrame
            : widget.face.startingFrame,
        duration: Duration(milliseconds: _isRunning ? 1000 : 400),
        curve: _isRunning ? Curves.easeInOutBack : Curves.easeInOutBack,
      )
          .whenComplete(() {
        if (willBackToNeutral) {
          _animationController.reset();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Offset facePosition = Offset.zero;

    if (widget.face == FaceExpression.angry) {
      facePosition = const Offset(0.275, 0.0);
    } else if (widget.face == FaceExpression.kindaAngry) {
      facePosition = const Offset(0.1, -0.1);
    } else if (widget.face == FaceExpression.kindaSad) {
      facePosition = const Offset(-0.1, -0.15);
    } else if (widget.face == FaceExpression.sad) {
      facePosition = const Offset(-0.2, -0.2);
    }

    return AnimatedSlide(
      duration: Duration(milliseconds: _isRunning ? 1000 : 400),
      curve: _isRunning ? Curves.easeInBack : Curves.easeInOutBack,
      offset: facePosition,
      child: Transform(
        transform: Matrix4.identity()..scale(0.5),
        alignment: Alignment.center,
        child: Lottie.asset(
          'assets/lotties/sun_faces.json',
          controller: _animationController,
        ),
      ),
    );
  }
}
