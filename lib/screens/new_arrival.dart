import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/models/product.dart';
import 'package:mool/providers/sort_new_arrivals_provider.dart';
import 'package:mool/widgets/home/product_card.dart';
import 'package:mool/widgets/home/sort.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class NewArrivalScreen extends ConsumerStatefulWidget {
  const NewArrivalScreen({super.key});

  @override
  createState() => _NewArrivalScreenState();
}

class _NewArrivalScreenState extends ConsumerState<NewArrivalScreen> {
  void _openSortOverlaySheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Sort(),
    );
  }

  // void _navigateToFiltersScreen() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(builder: (ctx) => Filter()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final newArrivals = ref.watch(sortedNewArrivalsProvider);

    return CustomScaffoldHeader(
      title: "New Arrivals",
      trailing: Icon(
        Icons.search_rounded,
        color: Colors.white,
      ),
      isSearch: true,
      bodyContent: Column(
        children: [
          Expanded(
              child:
                  _bodyContent(newArrivals: newArrivals)), // Wrap in Expanded
          _bottomContent(),
        ],
      ),
    );
  }

  Widget _bodyContent({required List<Product> newArrivals}) {
    return GridView(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 156 / 250,
      ),
      children: [
        for (final p in newArrivals)
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
          // VerticalDivider(
          //   color: Colors.grey,
          //   thickness: 1,
          //   width: 1,
          // ),
          // GestureDetector(
          //   onTap: _navigateToFiltersScreen,
          //   child: Row(
          //     children: const [
          //       Icon(Icons.sort, color: Colors.black),
          //       SizedBox(width: 8),
          //       Text(
          //         'FILTER',
          //         style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 14,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
