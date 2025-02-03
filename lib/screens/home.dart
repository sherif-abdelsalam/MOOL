import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/providers/get_new_best_provider.dart';
import 'package:mool/screens/best_sellers.dart';
import 'package:mool/screens/new_arrival.dart';
import 'package:mool/widgets/home/collections_slider.dart';
import 'package:mool/widgets/home/delivery.dart';
import 'package:mool/widgets/home/discount_banner.dart';
import 'package:mool/widgets/home/new_best_products.dart';
import 'package:mool/widgets/home/other_collections.dart';
import 'package:mool/widgets/home/slider_category.dart';
import 'package:mool/widgets/home/top_brands.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header_home.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void setNewArrivalScreen() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => NewArrivalScreen()));
    }

    void setBestSellersScreen() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => BestSellersScreen()));
    }

    final productData = ref.watch(productProvider);

    return productData.when(
      data: (data) {
        final newArrivals = data['newArrivals'] ?? [];
        final bestSellers = data['bestSellers'] ?? [];

        return CustomScaffoldHeaderHome(
          bodyContent: Container(
            color: Color(0xFFE9E8E8),
            child: ListView(
              children: [
                SliderCategory(),
                Delivery(),
                CollectionsSlider(),
                SizedBox(height: 32),
                OtherCollections(),
                SizedBox(height: 32),
                TopBrands(),
                NewBestProducts(
                  title: "New Arrivals",
                  onNavigate: setNewArrivalScreen,
                  identifier: "new",
                  newArrivalOrBest: newArrivals,
                ),
                SizedBox(height: 32),
                DiscountBanner(),
                NewBestProducts(
                  title: "Best Sellers",
                  onNavigate: setBestSellersScreen,
                  identifier: "best",
                  newArrivalOrBest: bestSellers,
                ),
                SizedBox(height: 64),
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
