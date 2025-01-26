import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/providers/favorites_provider.dart';
import 'package:mool/widgets/home/product_card.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class MyList extends ConsumerStatefulWidget {
  const MyList({super.key});

  @override
  ConsumerState<MyList> createState() => _MyListState();
}

class _MyListState extends ConsumerState<MyList> {
  @override
  Widget build(BuildContext context) {
    final favoriteProducts = ref.watch(favoriteProductProvider);
    Widget callbackContent = Center(
      child: Text("No favorite products are founded!"),
    );
    return CustomScaffoldHeader(
      title: "My List",
      bodyContent: Center(
        child: favoriteProducts.isEmpty
            ? callbackContent
            : GridView(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 156 / 250,
                ),
                children: [
                  for (final p in favoriteProducts)
                    ProductCard(
                      product: p,
                      identifierBestOrNew: 'fav',
                    )
                ],
              ),
      ),
    );
  }
}
