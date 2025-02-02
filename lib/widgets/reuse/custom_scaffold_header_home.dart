import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mool/screens/notifications.dart';

class CustomScaffoldHeaderHome extends StatefulWidget {
  const CustomScaffoldHeaderHome({super.key, required this.bodyContent});

  final Widget bodyContent;

  @override
  State<CustomScaffoldHeaderHome> createState() =>
      _CustomScaffoldHeaderHomeState();
}

class _CustomScaffoldHeaderHomeState extends State<CustomScaffoldHeaderHome> {
  bool isWomenSelected = true; // Default selection
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 94,
                color: const Color(0xFF292D32),
              ),
              Positioned(
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "images/mool_logo.png",
                          width: 100,
                        ),
                        Spacer(),
                        // SvgPicture.asset("images/search-normal.svg"),
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => Notifications(),
                                ),
                              );
                            },
                            child: SvgPicture.asset("images/notification.svg")),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTabButton(
                          title: 'WOMEN',
                          isSelected: isWomenSelected,
                          onTap: () {
                            setState(() {
                              isWomenSelected = true;
                            });
                          },
                        ),
                        SizedBox(width: 32),
                        _buildTabButton(
                          title: 'MEN',
                          isSelected: !isWomenSelected,
                          onTap: () {
                            setState(() {
                              isWomenSelected = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(child: isWomenSelected ? widget.bodyContent : _menWidget()),
        ],
      ),
    );
  }

  Widget _menWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Uh..oh no products are found!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          Text(
            "Try visiting us soon!",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color(0xFFCCCCCC),
              fontSize: 14,
              // fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(height: 3),
          Container(
            height: 3,
            width: 40,
            color: isSelected ? Colors.white : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
