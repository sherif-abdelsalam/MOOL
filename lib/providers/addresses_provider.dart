import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/shipping_address.dart';

final addressesProvider = StreamProvider<List<ShippingAddress>>((ref) {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  return FirebaseFirestore.instance
      .collection('addresses')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      return ShippingAddress.fromMap(doc.data());
    }).toList();
  });
});
