import 'package:flutter/material.dart';
import 'package:mool/data/dummy_categories.dart';

class SliderCategory extends StatelessWidget {
  const SliderCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 106,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sliderCategories.length,
          itemBuilder: (context, index) {
            final category = sliderCategories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(category.imageUrl),
                  ),
                  SizedBox(height: 4),
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
