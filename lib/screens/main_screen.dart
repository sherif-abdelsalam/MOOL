import 'package:flutter/material.dart';
import 'package:mool/widgets/animated_logo.dart';

class LogoScreen extends StatelessWidget {
  const LogoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "images/mool_back.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          AnimatedLogo(),
        ],
      ),
    );
  }
}
