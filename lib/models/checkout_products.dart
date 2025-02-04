import 'package:mool/models/cart_product.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

enum Status { pending, done, none }

class CheckoutProducts {
  CheckoutProducts({
    required this.checkoutProducts,
    required this.subTotal,
    required this.status,
    this.placedDate,
  }) : id = uuid.v4();

  final String id;
  final List<CartProduct> checkoutProducts;
  final double subTotal;
  final Status status;
  final DateTime? placedDate;
}
