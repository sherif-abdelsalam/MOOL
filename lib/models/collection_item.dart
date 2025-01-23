import 'package:flutter/material.dart';

class CollectionItem {
  final String title;
  final String imageUrl;
  final String buttonText;
  final Color textColor;
  final Color buttonColor;
  CollectionItem({
    required this.title,
    required this.imageUrl,
    required this.buttonText,
    required this.textColor,
    required this.buttonColor,
  });
}
