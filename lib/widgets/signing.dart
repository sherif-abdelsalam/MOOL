import 'package:flutter/material.dart';

class SigningButtons extends StatelessWidget {
  const SigningButtons(
      {super.key, required this.onRegister, required this.onLogin});
  final void Function() onRegister;
  final void Function() onLogin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 44,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Get your dream items easily with Mool\nand get other interesting offers",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              OutlinedButton(
                onPressed: onRegister,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 52, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: const BorderSide(
                    width: 2.0,
                  ),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 52, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              const Text(
                "Continue as ",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF666666),
                ),
              ),
              const Text(
                "guest",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            "By continuing , you agree to our ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF666666),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Terms and conditions",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
