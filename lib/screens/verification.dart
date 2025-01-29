import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mool/icons/arrow_back_icon.dart';
import 'package:mool/screens/reset_pw.dart';

class Verification extends StatefulWidget {
  const Verification({super.key, this.email});

  final String? email;

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  bool _isButtonEnabled = false;
  int _secondsRemaining = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _checkOTP() {
    setState(() {
      _isButtonEnabled =
          _controllers.every((controller) => controller.text.isNotEmpty);
    });
  }

  void _submitOTP() {
    print("OTP Submitted: ${_controllers.map((c) => c.text).join()}");
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
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  color: const Color.fromRGBO(41, 45, 50, 1),
                ),
                Positioned(
                  left: 8,
                  child: Row(
                    children: [
                      ArrowBackIcon(),
                      Text(
                        "Verification",
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              "images/otp.svg",
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                "Enter 4 Digits code has been sent to\n${widget.email}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers[index],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: const Color.fromARGB(255, 234, 234, 234),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onChanged: (_) => _checkOTP(),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 24),
            Text(
              "Resend code in 00:${_secondsRemaining.toString().padLeft(2, '0')}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isButtonEnabled ? _submitOTP : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 52, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => ResetPassword()));
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
