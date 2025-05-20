
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verstak/api_service.dart';
import 'package:verstak/navigation_cubit.dart';
import 'package:verstak/pages/user/login_page.dart';
import 'package:verstak/product.dart';
import 'package:verstak/widgets/custom_button.dart';

class WelcomePage extends StatelessWidget {
  final ApiService apiService;
  final List<Product> products;

  const WelcomePage({
    super.key,
    required this.apiService,
    required this.products
  });

  void navigateToLoginPage(BuildContext context, bool newUser) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(newUser: newUser, apiService: apiService, products: products,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(height: 27.5),
              Container(
                child: Center(
                  child: Text(
                    "Войдите или зарегистрируйтесь\nчтобы совершать покупки и\nполучать бонусы",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 22
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(height: 25),
              CustomButton(
                padding: 20.0,
                onTap: () => navigateToLoginPage(context, true),
                splashColor: Colors.white.withValues(alpha: 0.1),
                highlightColor: Colors.white.withValues(alpha: 0.1),
                mainColor: Color(0xFF187A3F),
                extraShadow: false,
                width: screenWidth,
                height: screenHeight * 0.045,
                text: "Регистрация",
                textColor: Colors.white,
                fontSize: 20,
                hasIcon: false,
              ),

              SizedBox(height: 11),
              CustomButton(
                padding: 20.0,
                onTap: () => navigateToLoginPage(context, false),
                splashColor: Colors.grey.withValues(alpha: 0.1),
                highlightColor: Colors.grey.withValues(alpha: 0.1),
                mainColor: Colors.white,
                extraShadow: true,
                width: screenWidth,
                height: screenHeight * 0.045,
                text: "Войти",
                textColor: Colors.black,
                fontSize: 20,
                hasIcon: false,
              ),

            ],
          )
      ),
    );
  }
}