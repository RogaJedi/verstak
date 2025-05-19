
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verstak/navigation_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [

          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 22.5),
            child: Row(
              children: [
                const Text(
                  "Номер телефона или email",
                  style: TextStyle(
                      color: Color(0xFF636060),
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffEDEDED)
              ),
            ),
          ),

          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 22.5),
            child: Row(
              children: [
                const Text(
                    "Пароль",
                  style: TextStyle(
                      color: Color(0xFF636060),
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffEDEDED)
              ),
            ),
          ),

          SizedBox(height: 15),
          InkWell(
            onTap: () {
            },
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.white.withValues(alpha: 0.1),
            highlightColor: Colors.white.withValues(alpha: 0.1),
            child: Ink(
              decoration: BoxDecoration(
                  color: Color(0xFF187A3F),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ]
              ),
              width: screenWidth * 0.5,
              height: screenHeight * 0.04,
              child: Center(
                child: Text(
                  "Войти",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
