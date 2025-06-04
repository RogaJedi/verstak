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
    return Center(
      child: Container(
        width: 100,
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              celebration.svgPath,
              width: 55,
              height: 55,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  celebration.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}