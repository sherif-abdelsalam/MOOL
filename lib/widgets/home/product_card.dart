import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/product.dart';
import 'package:mool/providers/favorites_provider.dart';
import 'package:mool/screens/product_details.dart';
import 'package:mool/utils/show_snack_bar.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard(
      {super.key, required this.product, required this.identifierBestOrNew});

  final Product product;
  final String identifierBestOrNew;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double? saleAmount = product.discount;
    final favoriteProducts = ref.watch(favoriteProductProvider);
    final isFavorite = favoriteProducts.contains(product);

    void toggleFavoriteProduct() {
      final isAdded = ref
          .read(favoriteProductProvider.notifier)
          .toggleMealNotifier(product);
      showSnackBar(context, isAdded);
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDetails(
              product: product,
              identifier: identifierBestOrNew,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 3,
        child: Stack(
          children: [
            Stack(
              children: [
                Hero(
                  tag: product.productCode + identifierBestOrNew,
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    height: 180,
                    width: 190,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: GestureDetector(
                    onTap: toggleFavoriteProduct,
                    child: Container(
                      width: 40,
                      height: 40,
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
                saleAmount == null
                    ? SizedBox.shrink()
                    : Positioned(
                        top: 10,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xFFF42C2C), // Background color
                          ),
                          child: Center(
                            child: Text(
                              '${product.discount!.toInt()}%',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            Positioned(
              bottom: 44,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Text(
                  product.title,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 8,
              right: 0,
              child: Row(
                children: [
                  saleAmount != null
                      ? Row(
                          children: [
                            Text(
                              product.price.toStringAsFixed(0),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              ' ${product.discount == null ? product.price.toStringAsFixed(0) : (product.price - product.price * product.discount! / 100).toStringAsFixed(0)} SAR',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          '${product.price.toStringAsFixed(0)} SAR',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  Spacer(),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                        color: Color(0xFF292D32),
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(16))),

                    child: Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                    ), // Add your icon here
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
