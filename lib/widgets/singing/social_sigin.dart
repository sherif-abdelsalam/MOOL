import 'package:flutter/material.dart';

class SocialSign extends StatefulWidget {
  const SocialSign({super.key});

  @override
  State<SocialSign> createState() => _SocialSignState();
}

class _SocialSignState extends State<SocialSign> {

  // Future signInWithGoogle() async {
  //   print("****************************//////// *******");

  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   // if (googleUser == null) {
  //   //   return;
  //   // }
  //   print("****************777777777777************//////// *******");

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   print("***********************************");

  //   // Once signed in, return the UserCredential
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //   Navigator.of(context)
  //       .pushReplacement(MaterialPageRoute(builder: (ctx) => TabsScreen()));
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 52),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "OR",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const Expanded(
                child: Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // signInWithGoogle();
              },
              child: Container(
                child: Image.asset(
                  "images/google.png",
                ),
              ),
            ),
            // SizedBox(width: 12),
            // Tab(
            //     icon: Image.asset(
            //   "images/apple.png",
            // )),
            // SizedBox(width: 12),
            // Tab(
            //     icon: Image.asset(
            //   "images/facebook.png",
            // )),
          ],
        ),
      ],
    );
  }
}
