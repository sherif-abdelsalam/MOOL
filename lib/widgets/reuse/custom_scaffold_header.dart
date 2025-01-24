import 'package:flutter/material.dart';
import 'package:mool/icons/arrow_back_icon.dart';

class CustomScaffoldHeader extends StatelessWidget {
  const CustomScaffoldHeader(
      {super.key,
      required this.title,
      required this.bodyContent,
      this.trailing});

  final Widget bodyContent;
  final String title;
  final Widget? trailing;
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
                height: 48,
                color: const Color(0xFF292D32),
              ),
              Positioned(
                left: 8,
                right: 16,
                child: Row(
                  children: [
                    ArrowBackIcon(),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    if (trailing != null) trailing!,
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(color: Color(0xFFE9E8E8), child: bodyContent),
          ),
        ],
      ),
    );
  }
}
