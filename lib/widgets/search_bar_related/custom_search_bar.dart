import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function() onTap;

  CustomSearchBar({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.035,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 7.5,),
            Icon(Icons.search_rounded, color: Color(0xff737373),),
            SizedBox(width: 7.5,),
            Text(
                "Найдем что-то красивое",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17.5
              ),
            )
          ],
        ),
      ),
    );
  }
}