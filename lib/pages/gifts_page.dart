import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GiftsPage extends StatelessWidget {
  const GiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
                "Для каждого праздника свой подарок!",
              style: TextStyle(
                fontSize: 30
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Optional: for spacing
              children: [
                SvgPicture.asset(
                  'assets/birthday.svg',
                  width: 60, // Specify desired width
                  height: 60, // Specify desired height
                ),
                SvgPicture.asset(
                  'assets/kosmonavtika.svg',
                  width: 60,
                  height: 60,
                ),
                SvgPicture.asset(
                  'assets/marrage.svg',
                  width: 60,
                  height: 60,
                ),
                SvgPicture.asset(
                  'assets/paskha.svg',
                  width: 60,
                  height: 60,
                ),
              ],

            )
          ],
        )
    );
  }
}