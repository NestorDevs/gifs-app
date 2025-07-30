import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GifShimmerPlaceholder extends StatelessWidget {
  const GifShimmerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(milliseconds: 1500),
      child: Container(
        color: Colors.white,
        height: 200,
      ),
    );
  }
}
