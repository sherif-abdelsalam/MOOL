import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mool/providers/shipping_addresses.dart';
import 'package:mool/screens/add_new_address.dart';
import 'package:mool/utils/button.dart';
import 'package:mool/widgets/checkout/build_shipping_card.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class AddressBook extends ConsumerWidget {
  const AddressBook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresses = ref.watch(addressesProvider);
    Widget content = Center(
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
          Button(
            btnText: "Add address",
            onTapBtn: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => AddNewAddressScreen()));
            },
          ),
        ],
      ),
    );
    if (addresses.isNotEmpty) {
      content = Column(
        children: [
          for (final sh in addresses) BuildShippingCard(sh: sh),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => AddNewAddressScreen()));
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
                      border: Border.all(color: Color(0xff4E4E4E), width: 2),
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
      );
    }

    return CustomScaffoldHeader(
      title: "Address Book",
      bodyContent: content,
    );
  }
}
