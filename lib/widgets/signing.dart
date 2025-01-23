import 'package:flutter/material.dart';

class SigningButtons extends StatelessWidget {
  const SigningButtons(
      {super.key, required this.onRegister, required this.onLogin});
  final void Function() onRegister;
  final void Function() onLogin;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Screen size

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: size.height * .03,
        horizontal: size.width * .06,
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
              Text(
                "Get your dream items easily with Mool \nand get other interesting offers",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * .03),
          Row(
            children: [
              OutlinedButton(
                onPressed: onRegister,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .118,
                      vertical: size.height * .015),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: const BorderSide(
                    width: 2.0,
                  ),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .118,
                      vertical: size.height * .015),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * .03),
          Row(
            children: [
              Text(
                "Continue as ",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  color: Color(0xFF666666),
                ),
              ),
              Text(
                "guest",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * .03),
          Text(
            "By continuing , you agree to our",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
              color: Color(0xFF666666),
            ),
          ),
          Text(
            "Terms and conditions",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
