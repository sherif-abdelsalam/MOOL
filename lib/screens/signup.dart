import 'package:flutter/material.dart';
import 'package:mool/icons/arrow_back_icon.dart';
import 'package:mool/widgets/singing/signup_from.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Image.asset("images/mool_logo.png", width: 145),
      //   elevation: 0,
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   // leading:
      // ),
      // extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "images/register_back.png",
              fit: BoxFit.cover,
              width: double.infinity,
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
              child: SignupFrom(), // Make SignupFrom scrollable
            ),
          ],
        ),
      ),
    );
  }
}
