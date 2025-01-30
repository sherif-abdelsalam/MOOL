import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';
import 'package:mool/widgets/singing/password.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  var _oldPassword = '';
  var _newPassword = '';
  var _confirmPassword = '';

  Future<void> changePassword() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        final user = FirebaseAuth.instance.currentUser;
        final email = user?.email;

        if (user == null || email == null) {
          throw 'No user is currently signed in';
        }

        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: _oldPassword,
        );
        try {
          await user.reauthenticateWithCredential(credential);

          if (_newPassword == _confirmPassword) {
            await user.updatePassword(_newPassword);
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('New passwords do not match'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } on FirebaseAuthException catch (e) {
          String errorMessage = 'Authentication failed';
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  TextStyle style = TextStyle(fontSize: 14, color: Color(0xff616161));
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHeader(
      title: "Your account",
      bodyContent: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "  Old Password",
                  style: style,
                ),
                SizedBox(height: 8),
                Password(
                    labelText: "", onSaveInput: (pass) => _oldPassword = pass),
                SizedBox(height: 16),
                Text("  New Password", style: style),
                SizedBox(height: 8),
                Password(
                    labelText: "", onSaveInput: (pass) => _newPassword = pass),
                SizedBox(height: 16),
                Text("  Confirm Password", style: style),
                SizedBox(height: 8),
                Password(
                    labelText: "",
                    onSaveInput: (pass) => _confirmPassword = pass),
                SizedBox(height: 48),
                Button(
                  btnText: "Change Password",
                  onTapBtn: changePassword,
                  hasNotOutsideColor: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
