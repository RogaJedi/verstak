import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verstak/pages/cart_page.dart';
import 'package:verstak/pages/gifts_page.dart';
import 'package:verstak/pages/home_page.dart';
import 'package:verstak/pages/user/user_page.dart';
import 'package:verstak/widgets/custom_bottom_bar.dart';

import 'api_service.dart';
import 'navigation_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HubPage(),
      ),
    );
  }
}

final apiService = MockApiService();

class HubPage extends StatelessWidget {
  HubPage({super.key});

  final List<Widget> _pages = [
    HomePage(apiService: apiService,),
    GiftsPage(),
    CartPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Container(
                    child: ElevatedButton(
                        onPressed: () => print("something"),
                        child: Text("add searchbar later")
                    ),
                  ),
                ),
                backgroundColor: Color(0xFF187A3F),
              ),
              backgroundColor: Colors.white,
              body: _pages[currentIndex],
              bottomNavigationBar: CustomBottomBar(
                activeIcons: [
                  'assets/home_filled.svg',
                  'assets/gift_filled.svg',
                  'assets/cart_filled.svg',
                  'assets/user_filled.svg',
                ],
                inactiveIcons: [
                  'assets/home_empty.svg',
                  'assets/gift_empty.svg',
                  'assets/cart_empty.svg',
                  'assets/user_empty.svg',
                ],
                onTap: (index) {
                  context.read<NavigationCubit>().setPage(index);
                },
                backgroundColor: const Color(0xFF187A3F),
              ),
            ),
          ],
        );
      },
    );
  }
}