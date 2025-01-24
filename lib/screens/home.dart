import 'package:flutter/material.dart';
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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void setNewArrivalScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => NewArrivalScreen()));
  }

  void setBestSellersScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => BestSellersScreen()));
  }

  @override
  Widget build(BuildContext context) {
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
            ),
            SizedBox(height: 32),
            DiscountBanner(),
            NewBestProducts(
              title: "Best Sellers",
              onNavigate: setBestSellersScreen,
              identifier: "best",
            ),
            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
