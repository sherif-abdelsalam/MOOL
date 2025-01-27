import 'package:flutter/material.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHeader (title: "Filter", bodyContent: Center(child: Text("Filters Screen")));
  }
}
