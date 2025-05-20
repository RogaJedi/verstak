import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserPageItem extends StatelessWidget {
  final Function() onTap;
  final String text;
  final bool hasCross;

  UserPageItem({
    super.key,
    required this.onTap,
    required this.text,
    this.hasCross = false
  });

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  text,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                  fontSize: 20
                ),
              ),
              hasCross
                  ? Icon(Icons.close_rounded, size: 30,)
                  : SvgPicture.asset(
                'assets/arrow.svg',
                width: screenWidth * 0.05,
                height: screenWidth * 0.05,
              ),

            ],
          ),
        ),
      ),
    );
  }
}