import 'package:flutter/material.dart';

class Sort extends StatefulWidget {
  const Sort({super.key});

  @override
  State<Sort> createState() => _SortState();
}

class _SortState extends State<Sort> {
  var isCheckedPriceToLow = false;
  var isCheckedPriceToHigh = false;
  var isCheckedRating = false;
  var isCheckedNewArrival = false;

  void checkPriceHighToLow() {
    setState(() {
      isCheckedPriceToLow = !isCheckedPriceToLow;
      if (isCheckedPriceToHigh) {
        isCheckedPriceToHigh = false;
      }
    });
  }

  void checkPriceLowToHigh() {
    setState(() {
      isCheckedPriceToHigh = !isCheckedPriceToHigh;
      if (isCheckedPriceToLow) {
        isCheckedPriceToLow = false;
      }
    });
  }

  void checkNewArrival() {
    setState(() {
      isCheckedNewArrival = !isCheckedNewArrival;
    });
  }

  void checkRatingHighToLow() {
    setState(() {
      isCheckedRating = !isCheckedRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Sorting",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: _style(title: "Price : High to Low"),
            trailing: GestureDetector(
                onTap: checkPriceHighToLow,
                child: _checkBox(checker: isCheckedPriceToLow)),
          ),
          ListTile(
            title: _style(title: "Price : Low to High"),
            trailing: GestureDetector(
                onTap: checkPriceLowToHigh,
                child: _checkBox(checker: isCheckedPriceToHigh)),
          ),
          ListTile(
            title: _style(title: "New Arrival"),
            trailing: GestureDetector(
                onTap: checkNewArrival,
                child: _checkBox(checker: isCheckedNewArrival)),
          ),
          ListTile(
            title: _style(title: "Rating : High to Low"),
            trailing: GestureDetector(
                onTap: checkRatingHighToLow,
                child: _checkBox(checker: isCheckedRating)),
          ),
        ],
      ),
    );
  }

  Widget _checkBox({required checker}) {
    return checker
        ? Icon(
            Icons.check_circle_rounded,
            size: 28,
          )
        : Icon(
            Icons.check_circle_outline_rounded,
            size: 28,
            opticalSize: 5,
          );
  }

  Widget _style({required title}) {
    return Text(
      title,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}
