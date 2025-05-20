import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verstak/auth/auth_cubit.dart';
import 'package:verstak/widgets/custom_button.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<AuthCubit, AppAuthState>(
        builder: (builder, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        padding: 0,
                        onTap: () {},
                        splashColor: Colors.grey.withValues(alpha: 0.1),
                        highlightColor: Colors.grey.withValues(alpha: 0.1),
                        mainColor: Colors.white,
                        extraShadow: true,
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.045,
                        text: "Избранное",
                        textColor: Colors.black,
                        fontSize: 20,
                        hasIcon: true,
                        icon: Icon(Icons.favorite_border),
                      ),


                      SizedBox(width: 20,),

                      CustomButton(
                        padding: 0,
                        onTap: () {},
                        splashColor: Colors.grey.withValues(alpha: 0.1),
                        highlightColor: Colors.grey.withValues(alpha: 0.1),
                        mainColor: Colors.white,
                        extraShadow: true,
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.045,
                        text: "Покупки",
                        textColor: Colors.black,
                        fontSize: 20,
                        hasIcon: true,
                        icon: Icon(Icons.shopping_bag_outlined),
                      ),
                    ],
                  ),
                  SizedBox(height: 18,),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(children: [Text("Мой профиль", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22.5),),],),
                  ),

                ],
              ),
            ),
          );
        }
    );
  }
}