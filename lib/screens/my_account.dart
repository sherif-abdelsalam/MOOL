import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mool/widgets/my_account/row_container.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

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
                SizedBox(height: 8),
                RowContainer(
                    icon: SvgPicture.asset("images/myaccount/box.svg"),
                    text: "Your Orders"),
                SizedBox(height: 8),
                RowContainer(
                    icon: SvgPicture.asset("images/myaccount/heart.svg"),
                    text: "My Favorite"),
                SizedBox(height: 8),
                RowContainer(
                    icon: SvgPicture.asset("images/myaccount/location.svg"),
                    text: "Address Book"),
                SizedBox(height: 8),
                RowContainer(
                    icon: SvgPicture.asset("images/myaccount/lock.svg"),
                    text: "Change Password"),
                SizedBox(height: 8),
                RowContainer(
                    icon: SvgPicture.asset(
                        "images/myaccount/language-square.svg"),
                    text: "Language"),
                SizedBox(height: 8),
                RowContainer(
                    icon: SvgPicture.asset("images/myaccount/global.svg"),
                    text: "Country"),
                SizedBox(height: 8),
                RowContainer(
                    icon: SvgPicture.asset("images/myaccount/information.svg"),
                    text: "About Us"),
                SizedBox(height: 8),
                RowContainer(
                    icon: SvgPicture.asset("images/myaccount/message-text.svg"),
                    text: "Contact Us"),
                SizedBox(height: 8),
                RowContainer(
                    icon: SvgPicture.asset("images/myaccount/logout.svg"),
                    text: "Logout"),
                SizedBox(height: 8),
              ],
            ),
          ),
        ));
  }
}
