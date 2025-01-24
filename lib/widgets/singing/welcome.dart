import 'package:flutter/material.dart';
import 'package:mool/screens/signin.dart';
import 'package:mool/screens/signup.dart';
import 'package:mool/widgets/singing/signing.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  void _signupScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Signup()));
  }

  void _signinScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Signin()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Screen size
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: size.height * 0.04), // 5% of screen height
        Center(
          child: Image.asset(
            "images/welcome.png",
            height: size.height * 0.25, // Adjust image size
          ),
        ),
        SizedBox(height: size.height * 0.02), // 5% of screen height
        Text(
          "    Find the\n    best Collection ",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: size.height * 0.02),
        SigningButtons(
          onRegister: _signupScreen, // Pass instance methods
          onLogin: _signinScreen,
        ),
      ],
    );
  }
}
