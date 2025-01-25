import 'package:flutter/material.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';

class WriteReviewScreen extends StatelessWidget {
  const WriteReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHeader(
        title: "Write Review", bodyContent: Text("data"));
  }
}
