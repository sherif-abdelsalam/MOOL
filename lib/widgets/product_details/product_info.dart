import 'package:flutter/material.dart';
import 'package:mool/widgets/product_details/subtitles_style.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.brand,
    required this.title,
    required this.price,
    this.discount,
  });

  final String title;
  final String brand;
  final double price;
  final double? discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SubtitlesStyle(title: title),
                Spacer(),
                _price(),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  brand,
                  style: TextStyle(
                    color: Color(0XFF636363),
                  ),
                ),
                Spacer(),
                Text(
                  "VAT included",
                  style: TextStyle(
                    color: Color(0XFF636363),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _price() {
    Widget priceContent = SubtitlesStyle(title: price.toInt().toString());
    if (discount != null) {
      priceContent = Row(
        children: [
          Text(
            price.toInt().toString(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(width: 8),
          SubtitlesStyle(
              title: '${(price * (1 - (discount! / 100))).toInt()} SAR'),
        ],
      );
    }
    return priceContent;
  }
}
