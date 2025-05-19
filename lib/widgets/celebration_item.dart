import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../celebration.dart';

class CelebrationItem extends StatelessWidget {
  final Celebration celebration;

  const CelebrationItem({
    super.key,
    required this.celebration,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            celebration.svgPath,
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 8), // Add some space between icon and text
          Text(
            celebration.name,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}