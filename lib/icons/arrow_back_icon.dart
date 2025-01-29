import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArrowBackIcon extends StatelessWidget {
  const ArrowBackIcon({
    super.key,
    this.route,
    this.isCartToBack,
  });

  final String? route;
  final bool? isCartToBack;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset('images/arrow-square-left.svg'),
      onPressed: () {
        isCartToBack != null
            ? Navigator.pop(context)
            : route != null
                ? Navigator.of(context).pushReplacementNamed(route!)
                : Navigator.pop(context);
      },
    );
  }
}
