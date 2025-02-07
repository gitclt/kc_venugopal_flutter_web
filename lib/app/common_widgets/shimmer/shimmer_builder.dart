import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBuilder extends StatelessWidget {
  final int rowCount;
  final List<double> sizes;

  const ShimmerBuilder(
      {super.key, required this.rowCount, required this.sizes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: rowCount,
      itemBuilder: (context, index) {
        return ShimmerLoader(sizes: sizes);
      },
    );
  }
}

class ShimmerLoader extends StatelessWidget {
  final List<double> sizes; // List of widths for each shimmer widget

  const ShimmerLoader({super.key, required this.sizes});

  @override
  Widget build(BuildContext context) {
    List<Widget> shimmerWidgets = sizes.map((size) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade200,
          child: Container(
            width: size,
            height: 25.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
          ),
        ),
      );
    }).toList();

    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: shimmerWidgets,
      ),
    );
  }
}
