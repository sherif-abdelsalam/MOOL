import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mool/models/shipping_address.dart';
import 'package:mool/providers/shipping_addresses.dart';
import 'package:mool/screens/checkout.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/checkout/add_new_address.dart';
import 'package:mool/widgets/checkout/build_shipping_card.dart';

class Shipping extends ConsumerStatefulWidget {
  const Shipping({super.key});

  @override
  ConsumerState<Shipping> createState() => _ShippingState();
}

class _ShippingState extends ConsumerState<Shipping> {
  var addNewAddress = false;
  void toggleAddNewAddress(bool v) {
    setState(() {
      addNewAddress = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    final shipAddress = ref.watch(addressesProvider);
    Widget shippingContent = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("images/no_address.svg"),
          SizedBox(height: 24),
          Text(
            "No Address Yet",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Please add your address for your better experience",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff9E9E9E),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );

    if (shipAddress.isNotEmpty) {
      shippingContent = Column(
        children: [
          for (final sh in shipAddress) BuildShippingCard(sh: sh),
        ],
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Enter your shipping address",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            addNewAddress
                ? AddNewAddress(
                    btnContent: "Confirm and continue",
                    onConfirmAddress: () {
                      setState(() {
                        toggleAddNewAddress(false);
                      });
                    },
                  )
                : Column(
                    children: [
                      shippingContent,
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            toggleAddNewAddress(true);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              Container(
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
                              SizedBox(width: 8),
                              Text("Add new address"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 120),
            shipAddress.isNotEmpty
                ? Button(
                    btnText: "Confirm and continue",
                    onTapBtn: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => CheckoutScreen(currentStep: 2),
                        ),
                      );
                    },
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
