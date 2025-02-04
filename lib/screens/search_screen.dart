import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/icons/arrow_back_icon.dart';
import 'package:mool/models/product.dart';
import 'package:mool/widgets/home/product_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key, this.isNewArrivals});
  final bool? isNewArrivals;
  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<Product> _foundNewArrivals = [];
  List<Product> newArrivals = [];

  void getProducts() async {
    final result = await FirebaseFirestore.instance
        .collection('products')
        .where('isNew', isEqualTo: true)
        .get();

    newArrivals =
        result.docs.map((doc) => Product.fromMap(doc.data(), doc.id)).toList();
    setState(() {
      _foundNewArrivals = newArrivals;
    });
  }

  @override
  initState() {
    getProducts();
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Product> results = [];
    if (enteredKeyword.isEmpty) {
      results = newArrivals;
    } else {
      results = newArrivals
          .where((prod) =>
              prod.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundNewArrivals = results;
    });
  }

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
                      child: ArrowBackIcon(),
                    ),
                    SizedBox(width: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.search_rounded,
                          size: 24,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: size.width * .70,
                          child: TextField(
                            onChanged: (value) => _runFilter(value),
                            decoration: const InputDecoration(
                              hintText: 'What are you looking for ?',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xffCECECE),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFE9E8E8),
              child: Column(
                children: [
                  Expanded(
                    child: _foundNewArrivals.isNotEmpty
                        ? _bodyContent(newArrivals: _foundNewArrivals)
                        : Center(
                            child: const Text(
                              'No results found',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
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
            identifierBestOrNew: 'search',
          )
      ],
    );
  }
}
