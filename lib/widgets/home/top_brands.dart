import 'package:flutter/material.dart';
import 'package:mool/data/top_brands.dart';

class TopBrands extends StatelessWidget {
  const   TopBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color(0xFFFFF5BE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Brands",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 164, // Specify a fixed height
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              children: [
                for (final b in topBrands) Image.asset(b),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
