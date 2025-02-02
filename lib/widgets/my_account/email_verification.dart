import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});
  @override
  createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  Timer? timer;
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    checkEmailVerification();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerification() async {
    timer = Timer.periodic(Duration(seconds: 3), (_) async {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.reload();

      if (user?.emailVerified == true) {
        setState(() {
          isEmailVerified = true;
        });
        timer?.cancel();

        Navigator.of(context)
            .pushNamedAndRemoveUntil("login", (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'A verification email has been sent to your new email address.\n'
                'Please verify your email to continue.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.currentUser?.sendEmailVerification();
                },
                child: Text('Resend Verification Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
