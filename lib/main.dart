import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/screens/main_screen.dart';
import 'package:mool/screens/signin.dart';
import 'package:mool/screens/signup.dart';
import 'package:mool/screens/tabs.dart';

// final theme = ThemeData(
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: const Color.fromARGB(255, 0, 0, 0),
//   ),
//   textTheme: const TextTheme(
//     displayLarge: TextStyle(fontFamily: 'Roboto'),
//     displayMedium: TextStyle(fontFamily: 'Roboto'),
//     displaySmall: TextStyle(fontFamily: 'Roboto'),
//     headlineLarge: TextStyle(fontFamily: 'Roboto'),
//     headlineMedium: TextStyle(fontFamily: 'Roboto'),
//     headlineSmall: TextStyle(fontFamily: 'Roboto'),
//     titleLarge: TextStyle(fontFamily: 'Roboto'),
//     titleMedium: TextStyle(fontFamily: 'Roboto'),
//     titleSmall: TextStyle(fontFamily: 'Roboto'),
//     bodyLarge: TextStyle(fontFamily: 'Roboto'),
//     bodyMedium: TextStyle(fontFamily: 'Roboto'),
//     bodySmall: TextStyle(fontFamily: 'Roboto'),
//     labelLarge: TextStyle(fontFamily: 'Roboto'),
//     labelMedium: TextStyle(fontFamily: 'Roboto'),
//     labelSmall: TextStyle(fontFamily: 'Roboto'),
//   ),
// );

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCzzjpv1JqoMo3FtY4_NXkrWslTcU10HJs",
      appId: "1:856970872407:android:ddf21cf6c028c0614a0512",
      messagingSenderId: "856970872407",
      projectId: "molo-115a3",
    ),
  );

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(
            '====================================== User is currently signed out!');
      } else {
        print('===========********************************* User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: theme,
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? TabsScreen()
          : LogoScreen(),
      routes: {
        "login": (context) => Signin(),
        "signup": (context) => Signup(),
        "tabs": (context) => TabsScreen(),
      },
    );
  }
}
