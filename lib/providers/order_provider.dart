import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mool/models/order.dart';

final orderProvider = StreamProvider<List<OrderItems>>((ref) {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId == null) {
    return Stream.value([]);
  }

  return FirebaseFirestore.instance
      .collection('orders')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) {
    final orders = snapshot.docs.map((doc) {
      final data = doc.data();
      print('Document data: $data'); 
      return OrderItems.fromMap(data);
    }).toList();
    print('Parsed orders: ${orders.length}'); 
    return orders;
  });
});