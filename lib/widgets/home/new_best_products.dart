import 'package:flutter/material.dart';
import 'package:mool/models/product.dart';
import 'package:mool/widgets/home/product_card.dart';

class NewBestProducts extends StatelessWidget {
  const NewBestProducts({
    super.key,
    required this.title,
    required this.onNavigate,
    required this.identifier,
    required this.newArrivalOrBest
  });
  final String title;
  final void Function() onNavigate;
  final String identifier;
  final List<Product> newArrivalOrBest;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                  onPressed: onNavigate,
                  child: Row(
                    children: [
                      Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF4E4E4E),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF4E4E4E),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newArrivalOrBest.length,
              itemBuilder: (context, index) {
                final product = newArrivalOrBest[index];
                return ProductCard(
                  product: product,
                  identifierBestOrNew: identifier,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
