import 'package:flutter/material.dart';

class SignupFrom extends StatelessWidget {
  const SignupFrom({super.key});

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();
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
        // key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter your first name',
                labelText: 'First name',
                filled: true,
                fillColor: Colors.white, // Background color
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      16), // Rounded corners for enabled state
                  borderSide: BorderSide(
                    color: Colors.white, // Border color for enabled state
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      16), // Rounded corners for focused state
                  borderSide: BorderSide(
                    color: Colors.black, // Border color when focused
                    width: 1.5,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.trim().length > 50) {
                  return 'Must be between 1 and 50 characters.';
                }
                return null;
              },
              onSaved: (newValue) {},
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter your last name',
                labelText: 'Last name',
                filled: true,
                fillColor: Colors.white, // Background color
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      16), // Rounded corners for enabled state
                  borderSide: BorderSide(
                    color: Colors.white, // Border color for enabled state
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      16), // Rounded corners for focused state
                  borderSide: BorderSide(
                    color: Colors.black, // Border color when focused
                    width: 1.5,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.trim().length > 50) {
                  return 'Must be between 1 and 50 characters.';
                }
                return null;
              },
              onSaved: (newValue) {},
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white, // Background color
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      16), // Rounded corners for enabled state
                  borderSide: BorderSide(
                    color: Colors.white, // Border color for enabled state
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      16), // Rounded corners for focused state
                  borderSide: BorderSide(
                    color: Colors.black, // Border color when focused
                    width: 1.5,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.trim().length > 50) {
                  return 'Must be between 1 and 50 characters.';
                }
                return null;
              },
              onSaved: (newValue) {},
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
