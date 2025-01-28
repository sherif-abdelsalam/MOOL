import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:mool/screens/address_book.dart';
import 'package:mool/screens/my_list.dart';
import 'package:mool/screens/your_orders.dart';
import 'package:mool/widgets/my_account/row_container.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Country? selectedCountry;
  bool showDropDown = false;
  void _navigator(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHeader(
      title: "My account",
      bodyContent: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              RowContainer(
                  icon: SvgPicture.asset("images/myaccount/user-square.svg"),
                  text: "Your Account"),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: () {
                  _navigator(YourOrdersScreen());
                },
                child: RowContainer(
                    icon: SvgPicture.asset("images/myaccount/box.svg"),
                    text: "Your Orders"),
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: () {
                  _navigator(MyList());
                },
                child: RowContainer(
                    icon: SvgPicture.asset("images/myaccount/heart.svg"),
                    text: "My Favorite"),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _navigator(AddressBook());
                },
                child: RowContainer(
                    icon: SvgPicture.asset("images/myaccount/location.svg"),
                    text: "Address Book"),
              ),
              const SizedBox(height: 8),
              RowContainer(
                  icon: SvgPicture.asset("images/myaccount/lock.svg"),
                  text: "Change Password"),
              const SizedBox(height: 8),
              RowContainer(
                  icon:
                      SvgPicture.asset("images/myaccount/language-square.svg"),
                  text: "Language"),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showDropDown = !showDropDown;
                  });
                },
                child: RowContainer(
                  icon: SvgPicture.asset("images/myaccount/global.svg"),
                  text: "Country",
                ),
              ),
              // if (showDropDown) _buildCountryDropdown(),
              const SizedBox(height: 8),
              RowContainer(
                icon: SvgPicture.asset("images/myaccount/information.svg"),
                text: "About Us",
              ),
              const SizedBox(height: 8),
              RowContainer(
                  icon: SvgPicture.asset("images/myaccount/message-text.svg"),
                  text: "Contact Us"),
              const SizedBox(height: 8),
              RowContainer(
                  icon: SvgPicture.asset("images/myaccount/logout.svg"),
                  text: "Logout"),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildCountryDropdown() {
  //   return DropdownButtonFormField<Country>(
  //     items: countries
  //         .map((Country country) => DropdownMenuItem(
  //               value: country,
  //               child: Row(
  //                 children: [
  //                   Text(country.flag),
  //                   const SizedBox(width: 8),
  //                   Text(
  //                     country.name.split(" ").first,
  //                     style: const TextStyle(fontSize: 14),
  //                   ),
  //                 ],
  //               ),
  //             ))
  //         .toList(),
  //     onChanged: (Country? value) {
  //       setState(() {
  //         selectedCountry = value;
  //       });
  //     },
  //     onSaved: (Country? value) {
  //       if (value != null) {
  //         selectedCountry = value;
  //       }
  //     },
  //     decoration: const InputDecoration(
  //       border: OutlineInputBorder(),
  //     ),
  //   );
  // }
}
