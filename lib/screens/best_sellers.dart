import 'package:flutter/material.dart';
import 'package:mool/data/dummy_products.dart';
import 'package:mool/widgets/home/product_card.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class BestSellersScreen extends StatelessWidget {
  const BestSellersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHeader(
      title: "Best Sellers",
      bodyContent: Center(
        child: _bodyContent(),
      ),
    );
  }

  Widget _bodyContent() {
    return GridView(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 156 / 250,
      ),
      children: [
        for (final p in dummyProducts)
          ProductCard(
            product: p,
            identifierBestOrNew: 'new',
          )
      ],
    );
  }
}
