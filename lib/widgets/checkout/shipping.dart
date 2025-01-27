import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/shipping_address.dart';
import 'package:mool/providers/shipping_addresses.dart';
import 'package:mool/screens/checkout.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/checkout/add_new_address.dart';

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
      child: Text("No addresses founded!"),
    );

    if (shipAddress.isNotEmpty) {
      shippingContent = Column(
        children: [
          for (final sh in shipAddress) buildShippingAddressCard(sh: sh),
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
                          padding: const EdgeInsets.all(8.0),
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

  Widget buildShippingAddressCard({required ShippingAddress sh}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(30),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping address',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Color(0xff33CCCC),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildAddressRow('Name', sh.fullName!),
            SizedBox(height: 8),
            _buildAddressRow('Street', sh.streetName!),
            SizedBox(height: 8),
            _buildAddressRow('Building No.', sh.buildingNameOrNumber!),
            SizedBox(height: 8),
            _buildAddressRow('City', sh.cityOrArea!),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
