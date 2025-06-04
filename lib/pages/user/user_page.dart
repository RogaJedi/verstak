import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verstak/auth/auth_cubit.dart';
import 'package:verstak/widgets/custom_button.dart';
import 'package:verstak/widgets/user_related/user_page_item.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});


  //context.read<AuthCubit>().signOut();
  Future<void> _showSignOutConfirmationDialog(BuildContext context, double height) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Container(
            height: height * 0.1,
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Выйти из аккаунта?',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: Text(
                          'Отмена',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthCubit>().signOut();
                          Navigator.of(dialogContext).pop();
                        },
                        child: Text(
                          'Да',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<AuthCubit, AppAuthState>(
        builder: (builder, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                      SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(children: [Text("Мой профиль", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22.5),),],),
                      ),
                      SizedBox(height: 15,),

                      UserPageItem(onTap: () {}, text: "Редактировать профиль"),
                      SizedBox(height: 5,),

                      UserPageItem(onTap: () {}, text: "Уведомления"),
                      SizedBox(height: 5,),

                      UserPageItem(onTap: () {}, text: "Купить сертификат"),
                      SizedBox(height: 5,),

                      UserPageItem(onTap: () {}, text: "Зарегистрировать магазин"),
                      SizedBox(height: 5,),

                      UserPageItem(onTap: () {}, text: "Способы оплаты"),
                      SizedBox(height: 5,),

                      UserPageItem(onTap: () {}, text: "FAQ | Частые вопросы"),
                      SizedBox(height: 5,),

                      UserPageItem(onTap: () {}, text: "Поддержка"),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      UserPageItem(onTap: () {}, text: "Сменить тему"),
                      SizedBox(height: 5,),

                      UserPageItem(
                        onTap: () {
                          _showSignOutConfirmationDialog(context, screenHeight);
                        },
                        text: "Выйти из аккаунта",
                        hasCross: true,
                      ),

                      SizedBox(height: 20,),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}