import 'package:flutter/material.dart';
import 'package:mool/widgets/home/collections_slider.dart';
import 'package:mool/widgets/home/delivery.dart';
import 'package:mool/widgets/home/slider_category.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHeaderHome(
      bodyContent: Container(
        color: const Color(0xFFE9E8E8),
        child: ListView(
          children: [
            SliderCategory(),
            Delivery(),
            CollectionsSlider(),
          ],
        ),
      ),
    );
  }
}
