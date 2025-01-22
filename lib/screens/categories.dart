import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mool/data/dummy_categories.dart';
import 'package:mool/widgets/category_item.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHeader(
      title: "Categories",
      trailing: GestureDetector(
          onTap: () {}, child: SvgPicture.asset("images/search-normal.svg")),
      bodyContent: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        children: [
          for (final category in categories)
            CategoryGridItem(
              category: category,
            ),
          for (final category in categories)
            CategoryGridItem(
              category: category,
            ),
          for (final category in categories)
            CategoryGridItem(
              category: category,
            ),
        ],
      ),
    );
  }
}
