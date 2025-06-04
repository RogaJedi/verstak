import 'package:flutter/material.dart';

class ScrollIndicator extends StatelessWidget {
  final double width;
  final double indicatorWidth;
  final double position; // от 0.0 до 1.0

  const ScrollIndicator({
    Key? key,
    required this.width,
    required this.indicatorWidth,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxOffset = width - indicatorWidth;
    final currentOffset = maxOffset * position;

    const lineHeight = 1.0;
    const indicatorHeight = 3.0;

    final verticalOffset = (indicatorHeight - lineHeight) / 2;

    return Container(
      width: width,
      height: indicatorHeight,
      child: Stack(
        children: [
          Positioned(
            top: verticalOffset,
            child: Container(
              width: width,
              height: lineHeight,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha:  0.3),
                borderRadius: BorderRadius.circular(lineHeight / 2),
              ),
            ),
          ),
          Positioned(
            left: currentOffset,
            child: Container(
              width: indicatorWidth,
              height: indicatorHeight,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
