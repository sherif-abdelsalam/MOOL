import 'package:flutter/material.dart';
import 'package:mool/icons/arrow_back_icon.dart';
import 'package:mool/screens/search_screen.dart';

class CustomScaffoldHeader extends StatelessWidget {
  const CustomScaffoldHeader({
    super.key,
    required this.title,
    required this.bodyContent,
    this.trailing,
    this.route,
    this.isCartToBack,
    this.isSearch = false,
  });

  final Widget bodyContent;
  final String title;
  final Widget? trailing;
  final String? route;
  final bool? isCartToBack;
  final bool? isSearch;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                height: 48,
                color: const Color(0xFF292D32),
              ),
              Positioned.fill(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: ArrowBackIcon(
                        route: route,
                        isCartToBack: isCartToBack,
                      ),
                    ),
                    SizedBox(
                    width: size.width*.66,
                      child: Text(
                        maxLines: 1,
                        title,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isSearch!)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      )
                    else if (trailing != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: trailing!,
                      ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFE9E8E8),
              child: bodyContent,
            ),
          ),
        ],
      ),
    );
  }
}

