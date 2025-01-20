import 'package:flutter/material.dart';
import 'package:mool/widgets/signing.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  void _signupScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Signup page"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: Colors.black), // Custom back button icon
            onPressed: () {
              // Define the behavior when the button is pressed
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(child: Text("Signup page")),
      );
    }));
  }

  void _signinScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Signin page"),
        ),
        body: Center(child: Text("Signin page")),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Center(child: Image.asset("images/welcome.png")),
        const SizedBox(height: 32),
        const Text(
          "   Find the\n   best Collection ",
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SigningButtons(
          onRegister: _signupScreen, // Pass instance methods
          onLogin: _signinScreen,
        ),
      ],
    );
  }
}
