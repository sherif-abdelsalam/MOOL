// import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:mool/screens/forget_pw.dart';
import 'package:mool/screens/signin.dart';
import 'package:mool/screens/signup.dart';
import 'package:mool/widgets/singing/email_input.dart';
import 'package:mool/widgets/singing/password.dart';
import 'package:mool/widgets/singing/social_sigin.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';

  void forgetPassword() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ForgetPW()));
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_enteredEmail);
      print(_enteredPassword);
    }
  }

  void saveEmail(String email) {
    _enteredEmail = email;
  }

  void savePassword(String password) {
    _enteredPassword = password;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 44,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              EmailInput(labelText: "Email", onSaveInput: saveEmail),
              SizedBox(height: 12),
              Password(labelText: "Password", onSaveInput: savePassword),
              SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 52, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: forgetPassword,
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(color: const Color(0xFF33CCCC)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have account?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.titleSmall!.fontSize),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => Signup(),
                        ),
                      );
                    },
                    child: Text(
                      "signup",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontSize:
                              Theme.of(context).textTheme.titleSmall!.fontSize),
                    ),
                  ),
                ],
              ),
              SocialSign(),
            ],
          ),
        ),
      ),
    );
  }
}
