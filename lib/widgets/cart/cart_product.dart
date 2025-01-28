import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/cart_product.dart';
import 'package:mool/providers/cart_product_provider.dart';
import 'package:mool/widgets/product_details/subtitles_style.dart';

class CartProductGridItem extends ConsumerStatefulWidget {
  const CartProductGridItem({
    super.key,
    required this.cartProd,
    required this.onChange,
  });
  final CartProduct cartProd;
  final void Function(double value) onChange;
  @override
  ConsumerState<CartProductGridItem> createState() => _CartProductState();
}

class _CartProductState extends ConsumerState<CartProductGridItem> {
  int quantity = 1;

  void setMinus() {
    setState(() {
      if (quantity > 1) {
        quantity--;
        widget.onChange(-widget.cartProd.product.price);
      }
    });
  }

  void setPlus() {
    setState(() {
      quantity++;
      widget.onChange(widget.cartProd.product.price);
    });
  }

  @override
  Widget build(BuildContext context) {
    CartProduct prod = widget.cartProd;

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Card(
        color: Colors.white,
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Image.asset(
                  prod.product.imageUrl,
                  height: 140,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 20,
                  child: prod.product.discount != null
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.red,
                          height: 30,
                          child: Center(
                              child: Text(
                            '${prod.product.discount!.toInt()}%',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )))
                      : SizedBox.shrink(),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prod.product.title,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    buildPriceWidget(prod),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Sold by : ',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff616161)),
                        ),
                        Flexible(
                          child: Text(
                            prod.product.brand,
                            style: TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff33CCCC)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xff616161),
                            ),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: setPlus,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Color(0xff4E4E4E), width: 2),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 16,
                                  ),
                                ),
                              ),
                              Text(
                                '   $quantity   ',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: setMinus,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Color(0xff4E4E4E), width: 2),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 45,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xff292D32),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18)),
              ),
              child: IconButton(
                icon: Icon(Icons.delete_outline_rounded, color: Colors.white),
                onPressed: () {
                  ref
                      .watch(cartProductsProvider.notifier)
                      .removeCartProduct(prod);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildPriceWidget(CartProduct prod) {
  // Check if there's a discount
  if (prod.product.discount != null) {
    // Calculate discounted price
    final originalPrice = prod.product.price.toInt();
    final discountPercentage = prod.product.discount!;
    final discountedPrice =
        (originalPrice * (1 - (discountPercentage / 100))).toInt();

    return Row(
      children: [
        // Original price (struck through)
        Text(
          originalPrice.toString(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(width: 8),
        // Discounted price
        SubtitlesStyle(
          title: '$discountedPrice SAR',
        ),
      ],
    );
  } else {
    // Regular price without discount
    return Text(
      '${prod.product.price} SAR',
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
