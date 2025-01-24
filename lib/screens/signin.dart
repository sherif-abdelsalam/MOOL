import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mool/icons/arrow_back_icon.dart';
import 'package:mool/widgets/singing/singin_form.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "images/signin_back.png",
              fit: BoxFit.cover,
              width: double.infinity,
              // height: double.infinity,
            ),
            Positioned(
              left: 20,
              top: 40,
              child: ArrowBackIcon(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SigninForm(), // Make SignupFrom scrollable
            ),
          ],
        ),
      ),
    );
  }
}
