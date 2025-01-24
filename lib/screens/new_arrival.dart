import 'package:flutter/material.dart';
import 'package:mool/data/dummy_categories.dart';
import 'package:mool/widgets/home/product_card.dart';
import 'package:mool/widgets/home/sort.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class NewArrivalScreen extends StatefulWidget {
  const NewArrivalScreen({super.key});

  @override
  State<NewArrivalScreen> createState() => _NewArrivalScreenState();
}

class _NewArrivalScreenState extends State<NewArrivalScreen> {
  void _openSortOverlaySheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Sort(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHeader(
      title: "New Arrivals",
      bodyContent: Column(
        children: [
          Expanded(child: _bodyContent()), // Wrap in Expanded
          _bottomContent(),
        ],
      ),
    );
  }

  Widget _bodyContent() {
    return GridView(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 156 / 250,
      ),
      children: [
        for (final p in dummyProducts)
          ProductCard(
            product: p,
            identifierBestOrNew: 'best',
          )
      ],
    );
  }

  Widget _bottomContent() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      color: Colors.white,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: _openSortOverlaySheet,
            child: Row(
              children: const [
                Icon(Icons.filter_list, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'SORT',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(
            color: Colors.grey,
            thickness: 1,
            width: 1,
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: const [
                Icon(Icons.sort, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'FILTER',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
