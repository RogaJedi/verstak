
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verstak/navigation_cubit.dart';
import 'package:verstak/pages/user/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: InkWell(
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
                        width: screenWidth,
                        height: screenHeight * 0.045,
                        child: Center(
                          child: Text(
                            "Регистрация",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 11),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: InkWell(
                      onTap: () {
                        context.read<NavigationCubit>().setPage(state.index + 1, true);
                      },
                      borderRadius: BorderRadius.circular(20),
                      splashColor: Colors.grey.withValues(alpha: 0.1),
                      highlightColor: Colors.grey.withValues(alpha: 0.1),
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 0),
                              ),
                            ]
                        ),
                        width: screenWidth,
                        height: screenHeight * 0.045,
                        child: Center(
                          child: Text(
                            "Войти",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        );
      },
    );
  }
}