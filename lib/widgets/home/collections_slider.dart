import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mool/data/dummy_categories.dart';

class CollectionsSlider extends StatefulWidget {
  const CollectionsSlider({super.key});

  @override
  State<CollectionsSlider> createState() => _CollectionsSliderState();
}

class _CollectionsSliderState extends State<CollectionsSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: collectionItems.length,
          itemBuilder: (context, index, realIndex) {
            final collection = collectionItems[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.hardEdge,
                elevation: 4,
                child: Stack(
                  children: [
                    Image.asset(
                      collection.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Positioned(
                      left: 20,
                      top: 20,
                      child: Text(
                        collection.title,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis, // tex...
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: collection.textColor,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 12,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            backgroundColor: collection.buttonColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: Text(
                          collection.buttonText,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 238,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            enlargeFactor:
                0.3, // This controls how much the center item enlarges
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: collectionItems.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _currentIndex == entry.key ? 16 : 8,
              height: 4,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentIndex == entry.key
                    ? const Color(0xFF38BCDD)
                    : const Color(0xFF616161),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
