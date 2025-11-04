import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DonutChartShimmer extends StatelessWidget {
  const DonutChartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.black26,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 10,
            children: List.generate(3, (_) {
              return Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(width: 50, height: 12, color: Colors.black12),
                    ],
                  ),
                  Container(width: 20, height: 12, color: Colors.black12),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
