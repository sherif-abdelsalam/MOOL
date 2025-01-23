import 'package:flutter/material.dart';
import 'package:mool/screens/main_screen.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 0, 0, 0),
  ),
  textTheme: const TextTheme( 
    displayLarge: TextStyle(fontFamily: 'Roboto'),
    displayMedium: TextStyle(fontFamily: 'Roboto'),
    displaySmall: TextStyle(fontFamily: 'Roboto'),
    headlineLarge: TextStyle(fontFamily: 'Roboto'),
    headlineMedium: TextStyle(fontFamily: 'Roboto'),
    headlineSmall: TextStyle(fontFamily: 'Roboto'),
    titleLarge: TextStyle(fontFamily: 'Roboto'),
    titleMedium: TextStyle(fontFamily: 'Roboto'),
    titleSmall: TextStyle(fontFamily: 'Roboto'),
    bodyLarge: TextStyle(fontFamily: 'Roboto'),
    bodyMedium: TextStyle(fontFamily: 'Roboto'),
    bodySmall: TextStyle(fontFamily: 'Roboto'),
    labelLarge: TextStyle(fontFamily: 'Roboto'),
    labelMedium: TextStyle(fontFamily: 'Roboto'),
    labelSmall: TextStyle(fontFamily: 'Roboto'),
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: LogoScreen(),
    );
  }
}
