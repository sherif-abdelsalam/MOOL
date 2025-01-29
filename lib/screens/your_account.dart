import 'package:flutter/material.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';
import 'package:mool/widgets/singing/email_input.dart';
import 'package:mool/widgets/singing/password.dart';
import 'package:mool/widgets/singing/text_input.dart';

class YourAccount extends StatefulWidget {
  const YourAccount({super.key});

  @override
  State<YourAccount> createState() => _YourAccountState();
}

class _YourAccountState extends State<YourAccount> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredEmail = '';
  var _enteredPhoneNumber = '';
  var _enteredPassword = '';

  void saveName(String name) {
    _enteredName = name;
  }

  void saveEmail(String email) {
    _enteredEmail = email;
  }

  void savePassword(String password) {
    _enteredPassword = password;
  }

  void savePhoneNumber(String phone) {
    _enteredPhoneNumber = phone;
  }

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
                Text("  Name"),
                SizedBox(height: 8),
                TextInput(labelText: "", onSaveInput: saveName),
                SizedBox(height: 16),
                Text("  Email"),
                SizedBox(height: 8),
                EmailInput(labelText: "", onSaveInput: saveEmail),
                SizedBox(height: 16),
                Text("  Phone"),
                SizedBox(height: 8),
                TextInput(labelText: "", onSaveInput: savePhoneNumber),
                SizedBox(height: 16),
                Text("  Password"),
                SizedBox(height: 8),
                Password(labelText: "", onSaveInput: savePassword),
                SizedBox(height: 48),
                Button(
                  btnText: "Update profile",
                  onTapBtn: () {},
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


// Container(
//       padding: EdgeInsets.symmetric(
//           horizontal: padding != null ? padding! : 16, vertical: 16),
//       width: double.infinity,
//       color: hasNotOutsideColor != null ? null : Colors.white,
//       child: ElevatedButton(
//         onPressed: onTapBtn,
//         style: ElevatedButton.styleFrom(
//           elevation: 16,
//           backgroundColor: Colors.black,
//           padding: EdgeInsets.symmetric(horizontal: 52, vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//         child: Text(
//           btnText,
//           style: TextStyle(
//               color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
//         ),
//       ),
//     );