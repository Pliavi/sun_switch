import 'package:flutter/material.dart';
import 'package:sun_switch/widgets/constants/sun_colors.dart';
import 'package:sun_switch/widgets/sun_switch.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SunColors.mainBackground,
      body: Center(
        child: SunSwitch(
          value: value,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
      ),
    );
  }
}
