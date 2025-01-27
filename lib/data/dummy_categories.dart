import 'package:flutter/material.dart';
import 'package:mool/models/category.dart';
import 'package:mool/models/collection_item.dart';

final categories = [
  Category(
      id: 'c1_sale_flash', name: 'SALE', imageUrl: 'images/flash_sale.png'),
  Category(
      id: 'c2_view_all', name: 'View All', imageUrl: 'images/view_all.png'),
  Category(id: 'c3_dresses', name: 'Dresses', imageUrl: 'images/dresses.png'),
  Category(id: 'c4_tops', name: 'Tops', imageUrl: 'images/tops.png'),
  Category(id: 'c5_bottoms', name: 'Bottoms', imageUrl: 'images/bottoms.png'),
  Category(id: 'c6_tshirts', name: 'T-Shirts', imageUrl: 'images/tshirts.png'),
  Category(id: 'c7_sale', name: 'SALE', imageUrl: 'images/sale.png'),
  Category(
      id: 'c8_nightwear', name: 'Nightwear', imageUrl: 'images/nightwear.png'),
];

final collectionItems = [
  CollectionItem(
    title: 'NEW\nSUMMER\nCOLLECTION\n2023',
    imageUrl: 'images/collection_1.png',
    buttonText: 'Shop now',
    textColor: Colors.black,
    buttonColor: Colors.black,
  ),
  CollectionItem(
    title: 'NEW\nSUMMER\nCOLLECTION\n2023',
    imageUrl: 'images/collection_2.png',
    buttonText: 'Watch now',
    textColor: Colors.white,
    buttonColor: Color(0xFF38BCDD),
  ),
  CollectionItem(
    title: 'NEW\nSUMMER\nCOLLECTION\n2023',
    imageUrl: 'images/collection_1.png',
    buttonText: 'Shop now',
    textColor: Colors.black,
    buttonColor: Colors.black,
  ),
];
