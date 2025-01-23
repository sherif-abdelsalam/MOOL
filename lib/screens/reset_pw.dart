import 'package:flutter/material.dart';
import 'package:mool/widgets/reuse/forget_reset_header.dart';
import 'package:mool/widgets/singing/password.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  var _newPassword;
  var _confirmPassword;

  void saveNewPassword(String password) {
    _newPassword = password;
  }

  void saveConfirmPassword(String password) {
    _confirmPassword = password;
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_newPassword == _confirmPassword) {
        print("Password reset successful");
      } else {
        
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 18,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ForgetResetHeader(header: "Reset\nPassword"),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 24,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Password(
                        labelText: "New Password",
                        onSaveInput: saveNewPassword),
                    SizedBox(height: 16),
                    Password(
                        labelText: "Confirm Password",
                        onSaveInput: saveNewPassword),
                    SizedBox(height: 120),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _resetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                              horizontal: 52, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
