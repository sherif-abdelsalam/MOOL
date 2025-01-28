import 'package:flutter/material.dart';
import 'package:mool/models/shipping_address.dart';

class BuildShippingCard extends StatelessWidget {
  const BuildShippingCard({super.key, required this.sh, this.isTransRev});
  final ShippingAddress sh;
  final bool? isTransRev;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isTransRev != null
              ? Border.all(color: Color(0xffcccccc), width: 1.5)
              : null,
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
