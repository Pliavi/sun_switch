import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:sun_switch/widgets/background_buildings.dart/background_buildings.dart';
import 'package:sun_switch/widgets/constants/sun_colors.dart';
import 'package:sun_switch/widgets/moving_sun.dart';
import 'package:sun_switch/widgets/sun_face.dart';

class SunSwitch extends StatefulWidget {
  const SunSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  State<SunSwitch> createState() => _SunSwitchState();
}

class _SunSwitchState extends State<SunSwitch> {
  SunExpression _sunExpression = SunExpression.neutral;
  final MaterialStatesController _statesController = MaterialStatesController();
  bool _isEnabled = true;
  bool get _isHovered {
    return _statesController.value.contains(MaterialState.hovered);
  }

  @override
  void initState() {
    super.initState();

    _statesController.addListener(_handleSwitchStateChange);
  }

  @override
  void dispose() {
    _statesController.removeListener(_handleSwitchStateChange);
    _statesController.dispose();

    super.dispose();
  }

  _handleSwitchStateChange() {
    if (!_isEnabled) return;

    if (_isHovered) {
      _sunExpression = widget.value ? SunExpression.sad : SunExpression.angry;
    } else {
      _sunExpression =
          widget.value ? SunExpression.kindaSad : SunExpression.neutral;
    }

    setState(() {});
  }

  @override
  void didUpdateWidget(SunSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _isEnabled = false;
      _sunExpression =
          widget.value ? SunExpression.kindaAngry : SunExpression.neutral;
    }
  }

  _handleSwitchTap() {
    if (_isEnabled) widget.onChanged?.call(!widget.value);
  }

  _handleSunRunningEnd() {
    _isEnabled = true;

    if (widget.value) {
      _sunExpression = _isHovered ? SunExpression.sad : SunExpression.kindaSad;
    } else {
      _sunExpression = _isHovered
          ? _sunExpression = SunExpression.angry
          : _sunExpression = SunExpression.neutral;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropShadow(
          child: InkWell(
            statesController: _statesController,
            onTap: _handleSwitchTap,
            child: Container(
              width: 150,
              height: 60,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: SunColors.sky,
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(
                    color: SunColors.shadow,
                    blurRadius: 3,
                    inset: true,
                  ),
                ],
              ),
              child: BackgroundBuildings(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    MovingSun(
                      side: widget.value ? SunSide.right : SunSide.left,
                      onEnd: _handleSunRunningEnd,
                      expression: _sunExpression,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      color: SunColors.shadow,
                      height: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
