import 'package:flutter/material.dart';
import 'package:mool/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    double? saleAmount = product.discount;

    return Card(
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
              Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                height: 180,
                width: 190,
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite_border_rounded),
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
                            '${product.discount}%',
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
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough),
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
    );
  }
}
