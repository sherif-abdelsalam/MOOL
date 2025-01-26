import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mool/providers/sort_provider.dart';

class Sort extends ConsumerWidget {
  const Sort({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOption = ref.watch(sortProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Sorting",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _buildSortTile(
            title: "Price : High to Low",
            option: SortOption.priceHighToLow,
            selectedOption: selectedOption,
            ref: ref,
          ),
          _buildSortTile(
            title: "Price : Low to High",
            option: SortOption.priceLowToHigh,
            selectedOption: selectedOption,
            ref: ref,
          ),
          _buildSortTile(
            title: "New Arrival",
            option: SortOption.newArrival,
            selectedOption: selectedOption,
            ref: ref,
          ),
          _buildSortTile(
            title: "Rating : High to Low",
            option: SortOption.ratingHighToLow,
            selectedOption: selectedOption,
            ref: ref,
          ),
        ],
      ),
    );
  }

  Widget _buildSortTile({
    required String title,
    required SortOption option,
    required SortOption selectedOption,
    required WidgetRef ref,
  }) {
    return ListTile(
      title: _style(title: title),
      trailing: GestureDetector(
        onTap: () => ref.read(sortProvider.notifier).setSort(option),
        child: _checkBox(isSelected: selectedOption == option),
      ),
      onTap: () => ref.read(sortProvider.notifier).setSort(option),
    );
  }

  Widget _checkBox({required bool isSelected}) {
    return Icon(
      isSelected ? Icons.check_circle_rounded : Icons.check_circle_outline_rounded,
      size: 28,
      opticalSize: isSelected ? null : 5,
    );
  }

  Widget _style({required String title}) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}