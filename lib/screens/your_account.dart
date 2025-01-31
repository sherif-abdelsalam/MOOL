import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';
import 'package:mool/widgets/singing/email_input.dart';
import 'package:mool/widgets/singing/text_input.dart';

class YourAccount extends StatefulWidget {
  const YourAccount({super.key, required this.userData});

  final Map<String, dynamic>? userData;

  @override
  State<YourAccount> createState() => _YourAccountState();
}

class _YourAccountState extends State<YourAccount> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredEmail = '';
  var _enteredPhoneNumber = '';

  void saveName(String name) {
    _enteredName = name;
  }

  void saveEmail(String email) {
    _enteredEmail = email;
  }

  void savePhoneNumber(String phone) {
    _enteredPhoneNumber = phone;
  }

  void updateProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_enteredEmail);
      print(_enteredPhoneNumber);
      print(_enteredName);
    }
  }

  @override
  void initState() {
    print("=====================================");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 14, color: Color(0xff616161));
    final userData = widget.userData;
    Map<String, dynamic> phoneNumberMap = userData!['phone_number'];
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
                  "  Name",
                  style: style,
                ),
                SizedBox(height: 8),
                TextInput(
                  labelText: "",
                  onSaveInput: saveName,
                  initialValue: userData['first_name'],
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
                  initialValue: userData['email'],
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
                  initialValue: phoneNumber.completeNumber
                ),
                SizedBox(height: 48),
                Button(
                  btnText: "Update profile",
                  onTapBtn: updateProfile,
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
