import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/checkout_products.dart';
import 'package:mool/providers/cart_product_provider.dart';
import 'package:mool/providers/checkout_provider.dart';
import 'package:mool/screens/checkout.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/cart/cart_product.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({
    super.key,
    this.isCartToBack,
  });
  final bool? isCartToBack;
  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  double _subtotal = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartProducts = ref.watch(cartProductsProvider);
      setState(() {
        for (final item in cartProducts) {
          double tmp = item.product.price;
          if (item.product.discount != null) {
            tmp = tmp * (1 - (item.product.discount! / 100));
          }
          _subtotal += tmp;
        }
      });
    });
  }

  void _setSubTotal(double value) {
    setState(() {
      _subtotal += value;
    });
  }

  void navigateToCheckout() {
    final cartProducts = ref.watch(cartProductsProvider);

    CheckoutProducts check = CheckoutProducts(
      checkoutProducts: cartProducts,
      subTotal: _subtotal,
      status: Status.pending,
    );

    ref.watch(checkoutProductsProvider.notifier).addCheckoutProducts(check);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => CheckoutScreen(currentStep: 1)));
  }

  @override
  Widget build(BuildContext context) {
    final cartProducts = ref.watch(cartProductsProvider);
    Widget fallbackContent = Center(
      child: Text("You cart is Empty!"),
    );
    return CustomScaffoldHeader(
      route: "tabs",
      title: "Cart",
      isCartToBack: widget.isCartToBack,
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
