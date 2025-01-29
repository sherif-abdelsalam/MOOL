import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:mool/widgets/discover/contert_screen.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class Discover extends StatelessWidget {
  const Discover({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> videos = [
      "videos/nature.mp4",
      "videos/menshawy.mp4",
      "videos/meadow.mp4",
      "videos/sunset.mp4"
    ];

    return CustomScaffoldHeader(
      route: "tabs",
      title: "Discover",
      bodyContent: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ContentScreen(
            src: videos[index],
          );
        },
        itemCount: videos.length,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
