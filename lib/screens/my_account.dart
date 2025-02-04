import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:mool/models/product.dart';
import 'package:mool/screens/address_book.dart';
import 'package:mool/screens/change_password.dart';
import 'package:mool/screens/my_list.dart';
import 'package:mool/screens/your_account.dart';
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

  void getUser() async {
    final users = FirebaseFirestore.instance.collection('users');

    final id = FirebaseAuth.instance.currentUser!.uid;
    final userEmail = FirebaseAuth.instance.currentUser!.email;

    DocumentSnapshot userDoc = await users.doc(id).get();
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      _navigator(YourAccount(
        userData: userData,
        userEmail: userEmail ?? "",
      ));
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Center(child: Text("We couldn't find your account!"))),
      );
    }
  }

  List<Product> products = [];

  Future<void> getProducts() async {
    final result =
        await FirebaseFirestore.instance.collection('products').get();

    setState(() {
      products = result.docs
          .map((doc) => Product.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHeader(
      route: "tabs",
      title: "My account",
      bodyContent: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  getUser();
                },
                child: RowContainer(
                    icon: SvgPicture.asset("images/user-square.svg"),
                    text: "Your Account"),
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: () async{
                  await getProducts();
                  _navigator(YourOrdersScreen(
                    products: products,
                  ));
                },
                child: RowContainer(
                    icon: SvgPicture.asset("images/box.svg"),
                    text: "Your Orders"),
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: () {
                  _navigator(MyList());
                },
                child: RowContainer(
                    icon: SvgPicture.asset("images/heart.svg"),
                    text: "My Favorite"),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _navigator(AddressBook());
                },
                child: RowContainer(
                    icon: SvgPicture.asset("images/location.svg"),
                    text: "Address Book"),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _navigator(ChangePassword());
                },
                child: RowContainer(
                    icon: SvgPicture.asset("images/lock.svg"),
                    text: "Change Password"),
              ),
              const SizedBox(height: 8),
              RowContainer(
                  icon: SvgPicture.asset("images/language-square.svg"),
                  text: "Language"),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showDropDown = !showDropDown;
                  });
                },
                child: RowContainer(
                  icon: SvgPicture.asset("images/global.svg"),
                  text: "Country",
                ),
              ),
              // if (showDropDown) _buildCountryDropdown(),
              const SizedBox(height: 8),
              RowContainer(
                icon: SvgPicture.asset("images/information.svg"),
                text: "About Us",
              ),
              const SizedBox(height: 8),
              RowContainer(
                  icon: SvgPicture.asset("images/message-text.svg"),
                  text: "Contact Us"),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  // GoogleSignIn googleSignIn = GoogleSignIn();
                  // googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                },
                child: RowContainer(
                    icon: SvgPicture.asset("images/logout.svg"),
                    text: "Logout"),
              ),
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
