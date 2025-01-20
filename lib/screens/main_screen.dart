import 'package:flutter/material.dart';
import 'package:mool/widgets/animated_logo.dart';

class LogoScreen extends StatelessWidget {
  const LogoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/mool_back.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Center(
            child: AnimatedLogo(),
          ),
        ],
      ),
    );
  }
}
