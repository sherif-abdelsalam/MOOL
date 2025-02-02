import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/my_account/email_verification.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';
import 'package:mool/widgets/singing/email_input.dart';
import 'package:mool/widgets/singing/text_input.dart';

class YourAccount extends StatefulWidget {
  const YourAccount({
    super.key,
    required this.userData,
    required this.userEmail,
  });

  final Map<String, dynamic> userData;
  final String userEmail;

  @override
  State<YourAccount> createState() => _YourAccountState();
}

class _YourAccountState extends State<YourAccount> {
  final _formKey = GlobalKey<FormState>();
  var _enteredFirstName = '';
  var _enteredLastName = '';
  var _enteredEmail = '';
  var _enteredPhoneNumber = '';

  void saveFirstName(String name) {
    _enteredFirstName = name;
  }

  void saveLastName(String name) {
    _enteredLastName = name;
  }

  void saveEmail(String email) {
    _enteredEmail = email;
  }

  void savePhoneNumber(String phone) {
    _enteredPhoneNumber = phone;
  }

  void updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        User usr = FirebaseAuth.instance.currentUser!;
        await usr.verifyBeforeUpdateEmail(_enteredEmail);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(usr.uid)
            .update({
          'first_name': _enteredFirstName,
          'last_name': _enteredLastName,
          'phone_number.number': _enteredPhoneNumber.substring(
            1,
            _enteredPhoneNumber.length,
          ),
        });

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmailVerificationScreen(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Login again first before updating your account info",
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }

  void deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          await _reAuthenticateUser();

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .delete();

          await user.delete();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Your account has been deleted successfully! We will miss you 😥"),
            ),
          );

          Navigator.of(context)
              .pushNamedAndRemoveUntil("signup", (route) => false);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error during re-authentication: $e"),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete account: $e"),
        ),
      );
    }
  }

  Future<void> _reAuthenticateUser() async {
    final passwordController = TextEditingController();
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Please enter your password to confirm account deletion'),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null && user.email != null) {
                  AuthCredential credential = EmailAuthProvider.credential(
                    email: user.email!,
                    password: passwordController.text,
                  );

                  await user.reauthenticateWithCredential(credential);
                  Navigator.of(context).pop();
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Invalid password")),
                );
              }
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Account'),
            content: Text(
                'Are you sure you want to delete your account? This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void initiateAccountDeletion() async {
    bool confirmDelete = await _showDeleteConfirmationDialog();
    if (confirmDelete) {
      deleteAccount();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 14, color: Color(0xff616161));
    final userData = widget.userData;
    Map<String, dynamic> phoneNumberMap = userData['phone_number'];
    PhoneNumber phoneNumber = PhoneNumber(
      countryISOCode: phoneNumberMap['countryISOCode'],
      countryCode: phoneNumberMap['countryCode'],
      number: phoneNumberMap['number'],
    );

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
                  "  First Name",
                  style: style,
                ),
                SizedBox(height: 8),
                TextInput(
                  labelText: "",
                  onSaveInput: saveFirstName,
                  initialValue: userData['first_name'],
                ),
                SizedBox(height: 16),
                Text(
                  "  Last Name",
                  style: style,
                ),
                SizedBox(height: 8),
                TextInput(
                  labelText: "",
                  onSaveInput: saveLastName,
                  initialValue: userData['last_name'],
                ),
                SizedBox(height: 16),
                Text(
                  "  Email",
                  style: style,
                ),
                SizedBox(height: 8),
                EmailInput(
                  labelText: "",
                  onSaveInput: saveEmail,
                  initialValue: widget.userEmail,
                ),
                SizedBox(height: 16),
                Text(
                  "  Phone",
                  style: style,
                ),
                SizedBox(height: 8),
                TextInput(
                  labelText: "",
                  onSaveInput: savePhoneNumber,
                  initialValue: "0${phoneNumber.number}",
                ),
                SizedBox(height: 48),
                Button(
                  btnText: "Update profile",
                  onTapBtn: updateProfile,
                  hasNotOutsideColor: true,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: initiateAccountDeletion,
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 2),
                      elevation: 16,
                      padding:
                          EdgeInsets.symmetric(horizontal: 52, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Delete account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
