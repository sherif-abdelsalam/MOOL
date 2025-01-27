import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/providers/cart_product_provider.dart';
import 'package:mool/screens/checkout.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/cart/cart_product.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  double _subtotal = 0;

  void _setSubTotal(double value) {
    setState(() {
      // _subtotal+=value;
    });
  }

  void navigateToCheckout() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => CheckoutScreen(currentStep: 1)));
  }

  @override
  Widget build(BuildContext context) {
    final cartProducts = ref.watch(cartProductsProvider);
    Widget fallbackContent = Center(
      child: Text("You cart is Empty!"),
    );
    if (cartProducts.isNotEmpty) {
      _subtotal = cartProducts.fold(0, (sum, item) => sum + item.product.price);
    }
    return CustomScaffoldHeader(
      title: "Cart",
      bodyContent: cartProducts.isEmpty
          ? fallbackContent
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Text(
                                "Subtotal",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                _subtotal.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        for (final cp in cartProducts)
                          CartProductGridItem(
                              cartProd: cp, onChange: _setSubTotal)
                      ],
                    ),
                  ),
                ),
                Button(
                    btnText: "Proceed to checkout",
                    onTapBtn: navigateToCheckout)
              ],
            ),
    );
  }
}
