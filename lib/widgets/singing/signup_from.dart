// import 'package:csc_picker/csc_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mool/screens/signin.dart';
import 'package:mool/utils/show_alert.dart';
import 'package:mool/widgets/singing/email_input.dart';
import 'package:mool/widgets/singing/password.dart';
import 'package:mool/widgets/singing/social_sigin.dart';
import 'package:mool/widgets/singing/text_input.dart';

class SignupFrom extends StatefulWidget {
  const SignupFrom({super.key});

  @override
  State<SignupFrom> createState() => _SignupFromState();
}

class _SignupFromState extends State<SignupFrom> {
  final _formKey = GlobalKey<FormState>();
  var _enteredFirstName = '';
  var _enteredLastName = '';
  var _enteredEmail = '';
  var _enteredPhoneNumber;
  var _enteredPassword = '';

  void addUser() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final uid = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> phoneNumberMap = {
      'countryISOCode': _enteredPhoneNumber.countryISOCode,
      'countryCode': _enteredPhoneNumber.countryCode,
      'number': _enteredPhoneNumber.number,
    };

    await users
        .doc(uid)
        .set(
          {
            'first_name': _enteredFirstName,
            'last_name': _enteredLastName,
            'phone_number': phoneNumberMap,
          },
        )
        .then((value) => print("===============>>>>User Added"))
        .catchError(
          (error) => print("==========>>>>>Failed to add user: $error"),
        );
  }

  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        addUser();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => Signin()),
        );
        
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'weak-password') {
          errorMessage = "The password provided is too weak.";
        } else if (e.code == 'email-already-in-use') {
          errorMessage =
              "The account already exists for that email! Try to Login";
        } else if (e.code == "network-request-failed") {
          errorMessage = "Connect to your network!";
        } else {
          errorMessage = "Inter valid credentials";
        }
        showAwesomeDialog(context, errorMessage, DialogType.warning);
      } catch (e) {
        print(e);
      }
    }
  }

  void saveFirstName(String fName) {
    _enteredFirstName = fName;
  }

  void saveLastName(String lName) {
    _enteredLastName = lName;
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
            TextInput(labelText: "First name", onSaveInput: saveFirstName),
            SizedBox(height: 12),
            TextInput(labelText: "Last name", onSaveInput: saveLastName),
            SizedBox(height: 12),
            EmailInput(labelText: "Email", onSaveInput: saveEmail),
            SizedBox(height: 12),
            IntlPhoneField(
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                labelText: "Phone number",
                labelStyle: TextStyle(fontSize: 14),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 8, horizontal: 12), // Adjust padding here
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.5)),
              ),
              initialCountryCode: 'EG',
              onSaved: (phone) {
                _enteredPhoneNumber = phone;
              },
            ),
            SizedBox(height: 12),
            Password(labelText: "Password", onSaveInput: savePassword),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 52, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize,
                      fontWeight: FontWeight.w900),
                ),
              ),
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
                        builder: (ctx) => Signin(),
                      ),
                    );
                  },
                  child: Text(
                    "Login",
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
    );
  }
}
