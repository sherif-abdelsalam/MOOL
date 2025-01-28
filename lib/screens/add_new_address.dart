import 'package:flutter/material.dart';
import 'package:mool/screens/address_book.dart';
import 'package:mool/widgets/checkout/add_new_address.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHeader(
      title: "Address Book",
      bodyContent: SingleChildScrollView(
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
              AddNewAddress(
                btnContent: "Add Address",
                onAddAddress: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => AddressBook()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
