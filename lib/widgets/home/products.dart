import 'package:flutter/material.dart';
import 'package:mool/models/product.dart';
import 'package:mool/widgets/home/product_card.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class Products extends StatelessWidget {
  const Products({super.key, required this.title, required this.prods});
  final List<Product> prods;
  final String title;

  @override
  Widget build(BuildContext context) {
    Widget callbackContent = Center(
      child: Text("No products are founded! in this category!"),
    );

    return CustomScaffoldHeader(
      title: title,
      bodyContent: Center(
        child: prods.isEmpty
            ? callbackContent
            : GridView(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 156 / 250,
                ),
                children: [
                  for (final Product p in prods)
                    ProductCard(
                      product: p,
                      identifierBestOrNew: title,
                    ),
                ],
              ),
      ),
    );
  }
}
