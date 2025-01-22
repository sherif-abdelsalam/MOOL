import 'package:flutter/material.dart';
import 'package:mool/icons/arrow_back_icon.dart';
import 'package:mool/screens/verification.dart';
import 'package:mool/widgets/singing/email_input.dart';

class ForgetPW extends StatefulWidget {
  const ForgetPW({super.key});

  @override
  State<ForgetPW> createState() => _ForgetPWState();
}

class _ForgetPWState extends State<ForgetPW> {
  final _formKey = GlobalKey<FormState>();

  var _enteredEmail;
  void saveEmail(String email) {
    _enteredEmail = email;
  }

  void _saveUser() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => Verification(
                email: _enteredEmail,
              )));
      // print(_enteredEmail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 18,
        automaticallyImplyLeading: false, //
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 160,
                color: const Color(0xFF292D32),
              ),
              Positioned(
                left: 8,
                child: ArrowBackIcon(),
              ),
              Positioned(
                left: 20,
                top: 54,
                child: Text(
                  "Forget\nPassword",
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium!.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
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
                  EmailInput(labelText: "Email", onSaveInput: saveEmail),
                  SizedBox(height: 80),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 52, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
