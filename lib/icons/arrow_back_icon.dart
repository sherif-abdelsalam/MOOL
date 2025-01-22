import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArrowBackIcon extends StatelessWidget {
  const ArrowBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset('images/arrow-square-left.svg'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
