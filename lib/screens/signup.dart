import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mool/widgets/signup_from.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/mool_logo.png", width: 145),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: SvgPicture.asset('images/arrow-square-left.svg'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            "images/register_back.png",
            fit: BoxFit.cover,
            width: double.infinity,
            // height: double.infinity,
          ),
          Positioned(
             left: 20,
             top: 200,
            child: Text(
              "Create Account",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SignupFrom(),),
        ],
      ),
    );
  }
}
