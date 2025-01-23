import 'package:flutter/material.dart';
import 'package:mool/widgets/welcome.dart';

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({super.key});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;
  bool showContent = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward().then((_) {
        setState(() {
          showContent = true;
        });
      });

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Screen size
    double logoSize = showContent ? size.width*.4 : size.width*.8;
    Widget content = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Image.asset(
            "images/mool_logo.png",
            width: logoSize,
          ),
        );
      },
    );

    return !showContent
        ? Center(child: content)
        : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              content,
              Welcome(),
            ],
          );
  }
}
