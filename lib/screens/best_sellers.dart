import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/providers/get_new_best_provider.dart';
import 'package:mool/widgets/home/product_card.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class BestSellersScreen extends ConsumerWidget {
  const BestSellersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsData = ref.watch(productProvider);
    return productsData.when(
      data: (data) {
        final bestSellers = data['bestSellers'] ?? [];
        return CustomScaffoldHeader(
          title: "Best Sellers",
          bodyContent: Center(
            child: GridView(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 156 / 250,
              ),
              children: [
                for (final p in bestSellers)
                  ProductCard(
                    product: p,
                    identifierBestOrNew: 'new',
                  ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
