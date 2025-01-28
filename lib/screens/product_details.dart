import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/cart_product.dart';
import 'package:mool/models/product.dart';
import 'package:mool/models/rating_result.dart';
import 'package:mool/models/review.dart';
import 'package:mool/providers/cart_product_provider.dart';
import 'package:mool/providers/favorites_provider.dart';
import 'package:mool/providers/reviews_provider.dart';
import 'package:mool/screens/cart.dart';
import 'package:mool/screens/reviews.dart';
import 'package:mool/screens/write_review.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/utils/show_snack_bar.dart';
import 'package:mool/widgets/product_details/product_info.dart';
import 'package:mool/widgets/product_details/rating_lines.dart';
import 'package:mool/widgets/product_details/reviews.dart';
import 'package:mool/widgets/product_details/see_all_reviews.dart';
import 'package:mool/widgets/product_details/service_feature.dart';
import 'package:mool/widgets/product_details/subtitles_style.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class ProductDetails extends ConsumerStatefulWidget {
  const ProductDetails(
      {super.key, required this.product, required this.identifier});
  final Product product;
  final String identifier;

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  String selectedSize = "L";
  void selectSize(String size) {
    setState(() {
      selectedSize = size;
    });
  }

  Color selectedColor = Colors.white;

  void selectColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

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
    final revs = ref.watch(reviewsProvider);
    final reviews =
        revs.where((rev) => rev.productId == widget.product.id).toList();

    Widget reviewContent = Center(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "No reviews for this product!",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff4E4E4E),
              ),
            ),
          ),
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

    void toggleFavoriteProduct() {
      var addMessage = "Product added to favorites 🤩";
      var removeMessage = "Product is no longer exist in favorites 😔";
      final isAdded = ref
          .read(favoriteProductProvider.notifier)
          .toggleMealNotifier(widget.product);
      showSnackBar(context, isAdded, addMessage, removeMessage);
    }

    final favoriteProducts = ref.watch(favoriteProductProvider);
    final isFavorite = favoriteProducts.contains(widget.product);

    void saveProduct() {
      final cart = ref.watch(cartProductsProvider);
      CartProduct cartProduct = CartProduct(
        id: (cart.length+1).toString(),
          product: widget.product, color: selectedColor, size: selectedSize);
      ref.watch(cartProductsProvider.notifier).addCartProduct(cartProduct);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => CartScreen()));
    }

    return CustomScaffoldHeader(
        title: widget.product.title,
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
                        tag: widget.product.productCode + widget.identifier,
                        child: Image.asset(
                          widget.product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 20,
                        child: GestureDetector(
                          onTap: toggleFavoriteProduct,
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: Tween<double>(
                                    begin: 3,
                                    end: 1,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                key: ValueKey(isFavorite),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 40,
                          child: widget.product.discount != null
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  color: Colors.red,
                                  child: Center(
                                    child: Text(
                                      '${widget.product.discount!.toInt().toString()}%',
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
                  brand: widget.product.brand,
                  title: widget.product.title,
                  price: widget.product.price,
                  discount: widget.product.discount,
                ),
                SizedBox(height: 4),
                _returnPolicy(),
                SizedBox(height: 4),
                _productDetailsInfo(),
                SizedBox(height: 4),
                reviewContent,
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => WriteReviewScreen(
                          revsLen: reviews.length,
                          prodId: widget.product.id,
                        ),
                      ),
                    );
                  },
                  child: _writeReview(),
                ),
                SizedBox(height: 12),
                _packagingAndReturn(),
                SizedBox(height: 18),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child:
                        Button(btnText: "Add to cart", onTapBtn: saveProduct),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _writeReview() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Text(
              "Write Review",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff38BCDD),
              ),
            ),
          ],
        ),
      ),
    );
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
            for (final size in widget.product.sizes)
              GestureDetector(
                onTap: () => selectSize(size),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: selectedSize == size
                            ? Color(0xff292D32)
                            : Colors.white,
                        border: Border.all(
                          color: Color(0xff616161),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          size,
                          style: TextStyle(
                              color: selectedSize == size
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
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
            for (final c in widget.product.colors)
              Row(
                children: [
                  GestureDetector(
                    onTap: () => selectColor(c),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selectedColor == c ? c : c.withAlpha(40),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: selectedColor == c
                                ? Colors.red
                                : Color(0xff616161),
                            width: selectedColor == c ? 2 : 1), // Add border
                      ),
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
          widget.product.description,
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
                    prodTitle: "Product Code",
                    prodCont: widget.product.productCode),
                SizedBox(height: 8),
                _productDetailsOutTemp(
                    prodTitle: "Fabric", prodCont: widget.product.fabric),
                SizedBox(height: 8),
                _productDetailsOutTemp(
                    prodTitle: "Shape", prodCont: widget.product.shape),
              ],
            ),
            SizedBox(width: 52),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _productDetailsOutTemp(
                    prodTitle: "Brand", prodCont: widget.product.brand),
                SizedBox(height: 8),
                _productDetailsOutTemp(
                    prodTitle: "Model wearin size",
                    prodCont: widget.product.model),
                SizedBox(height: 8),
                _productDetailsOutTemp(
                    prodTitle: "Shape", prodCont: widget.product.shape),
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
