import 'package:flutter/material.dart';
import 'package:mool/data/dummy_categories.dart';

class SliderCategory extends StatelessWidget {
  const SliderCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 26,
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
