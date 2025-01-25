import 'package:flutter/material.dart';
import 'package:mool/data/dummy_reviews.dart';
import 'package:mool/models/product.dart';
import 'package:mool/models/rating_result.dart';
import 'package:mool/models/review.dart';
import 'package:mool/screens/reviews.dart';
import 'package:mool/widgets/product_details/product_info.dart';
import 'package:mool/widgets/product_details/rating_lines.dart';
import 'package:mool/widgets/product_details/reviews.dart';
import 'package:mool/widgets/product_details/see_all_reviews.dart';
import 'package:mool/widgets/product_details/service_feature.dart';
import 'package:mool/widgets/product_details/subtitles_style.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails(
      {super.key, required this.product, required this.identifier});
  final Product product;
  final String identifier;

  RatingResult getAverageRating(List<Review> revs) {
    double sumRatings = 0;
    Map<int, int> frequencyRatings = {};

    for (int i = 0; i < revs.length; i++) {
      double rate = revs[i].rating;
      sumRatings += rate;
      frequencyRatings[rate.toInt()] =
          (frequencyRatings[rate.toInt()] ?? 0) + 1;
    }
    return RatingResult(sumRatings / revs.length, frequencyRatings);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final reviews =
        dummyReviews.where((rev) => rev.productId == product.id).toList();

    Widget reviewContent = Center(
      child: Text(
        "No reviews for this product",
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff4E4E4E),
        ),
      ),
    );
    if (reviews.isNotEmpty) {
      var avgRating = 0.0;
      Map<int, int> frequencyRatings = {};
      RatingResult res = getAverageRating(reviews);
      avgRating = res.averageRating;
      frequencyRatings = res.frequencyRatings;
      reviewContent = Column(
        children: [
          RatingLines(
            avgRatings: avgRating,
            frequencyRatings: frequencyRatings,
            reviewsLength: reviews.length,
          ),
          Reviews(
            revs: [reviews[0]],
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ReviewsScreen(
                      revs: reviews,
                      ratingLines: RatingLines(
                        avgRatings: avgRating,
                        frequencyRatings: frequencyRatings,
                        reviewsLength: reviews.length,
                      ),
                    ),
                  ),
                );
              },
              child: SeeAllReviews()),
        ],
      );
    }

    return CustomScaffoldHeader(
        title: product.title,
        bodyContent: Container(
          color: Color(0xffE9E8E8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: size.width,
                  child: Stack(
                    children: [
                      Hero(
                        tag: product.productCode + identifier,
                        child: Image.asset(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          top: 40,
                          child: product.discount != null
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  color: Colors.red,
                                  child: Center(
                                    child: Text(
                                      '${product.discount!.toInt().toString()}%',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink())
                    ],
                  ),
                ),
                ProductInfo(
                  brand: product.brand,
                  title: product.title,
                  price: product.price,
                  discount: product.discount,
                ),
                SizedBox(height: 4),
                _returnPolicy(),
                SizedBox(height: 4),
                _productDetailsInfo(),
                SizedBox(height: 4),
                reviewContent,
                SizedBox(height: 4),
                _packagingAndReturn(),
              ],
            ),
          ),
        ));
  }

  Widget _productDetailsInfo() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _productSizes(),
            SizedBox(height: 16),
            _productColors(),
            SizedBox(height: 16),
            _productDescription(),
            SizedBox(height: 16),
            _productDetails(),
          ],
        ),
      ),
    );
  }

  Widget _productSizes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtitlesStyle(title: 'Size'),
        SizedBox(height: 8),
        Row(
          children: [
            for (final size in product.sizes)
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey), // Add border
                    ),
                    child: Center(child: Text(size)),
                  ),
                  SizedBox(width: 8),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Widget _productColors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtitlesStyle(title: 'Colors'),
        SizedBox(height: 8),
        Row(
          children: [
            for (final c in product.colors)
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: c,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey), // Add border
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Widget _productDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtitlesStyle(title: "Description"),
        SizedBox(height: 8),
        Text(
          product.description,
          style: TextStyle(
            color: Color(0xff4E4E4E),
          ),
        )
      ],
    );
  }

  Widget _productDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtitlesStyle(title: "Product Details"),
        SizedBox(height: 8),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _productDetailsOutTemp(
                    prodTitle: "Product Code", prodCont: product.productCode),
                SizedBox(height: 8),
                _productDetailsOutTemp(
                    prodTitle: "Fabric", prodCont: product.fabric),
                SizedBox(height: 8),
                _productDetailsOutTemp(
                    prodTitle: "Shape", prodCont: product.shape),
              ],
            ),
            SizedBox(width: 52),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _productDetailsOutTemp(
                    prodTitle: "Brand", prodCont: product.brand),
                SizedBox(height: 8),
                _productDetailsOutTemp(
                    prodTitle: "Model wearin size", prodCont: product.model),
                SizedBox(height: 8),
                _productDetailsOutTemp(
                    prodTitle: "Shape", prodCont: product.shape),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _productDetailsOutTemp({required prodTitle, required prodCont}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          prodTitle,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xff616161),
          ),
        ),
        SizedBox(height: 4),
        Text(
          prodCont,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  Widget _returnPolicy() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              "Return Policy",
              style: TextStyle(fontSize: 14),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
            )
          ],
        ),
      ),
    );
  }

  Widget _packagingAndReturn() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ServiceFeature(
            icon: Icons.verified_user_rounded,
            title: 'Safe packaging',
            description: 'Orders are sanitized\nand packed',
          ),
          SizedBox(width: 16),
          Container(
            width: 1,
            height: 88,
            color: Color(0xffCCCCCC),
          ),
          SizedBox(width: 16),
          ServiceFeature(
            icon: Icons.replay_outlined,
            title: 'Easy Return',
            description: '15 Days Easy Return',
          ),
        ],
      ),
    );
  }
}
