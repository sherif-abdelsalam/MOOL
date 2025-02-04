import 'package:flutter/material.dart';
import 'package:mool/models/checkout_products.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class OrderItems {
  final String userId;
  final Status status;
  final DateTime placedDate;
  final double subTotal;
  final List<OrderProduct> orderProducts;
  final String id;

  OrderItems({
    required this.orderProducts,
    required this.placedDate,
    required this.status,
    required this.subTotal,
    required this.userId,
  }) : id = uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'status': status.toString().split('.').last, 
      'placedDate': placedDate.toIso8601String(),
      'subTotal': subTotal,
      'orderProducts': orderProducts.map((e) => e.toMap()).toList(),
    };
  }

  factory OrderItems.fromMap(Map<String, dynamic> map) {
    return OrderItems(
      userId: map['userId'] as String,
      status: Status.values.firstWhere(
        (e) => e.toString() == 'Status.${map['status']}',
        orElse: () => Status.none,
      ),
      placedDate: DateTime.parse(map['placedDate'] as String),
      subTotal: (map['subTotal'] as num).toDouble(),
      orderProducts: (map['orderProducts'] as List<dynamic>)
          .map((e) => OrderProduct.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class OrderProduct {
  final String prodId;
  final Color color;
  final String size;

  const OrderProduct({
    required this.color,
    required this.prodId,
    required this.size,
  });

  Map<String, dynamic> toMap() {
    return {
      'prodId': prodId,
      'color': color.value.toString(),
      'size': size,
    };
  }

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      prodId: map['prodId'] as String,
      color: Color(int.parse(map['color'] as String)), // Parse string to int
      size: map['size'] as String,
    );
  }
}
