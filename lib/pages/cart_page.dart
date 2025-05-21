import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verstak/api_service.dart';
import 'package:verstak/models/product.dart';
import 'package:verstak/pages/order_page.dart';
import 'package:verstak/user_state_management/user_cubit.dart';
import 'package:verstak/widgets/cart_related/cart_ui_item.dart';
import 'package:verstak/widgets/custom_button.dart';

import '../auth/auth_cubit.dart';
import '../user_state_management/user_state.dart';
import '../widgets/product_related/product_card.dart';

class CartPage extends StatelessWidget {

  final ApiService apiService;
  final List<Product> allProducts;


  CartPage({
    super.key,
    required this.apiService,
    required this.allProducts,
  });

  void navigateToOrderPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderPage()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<AuthCubit, AppAuthState>(
        builder: (context, authState) {
          return Scaffold(
            body: Center(
                child: authState is AuthAuthenticated


                    ? BlocBuilder<UserCubit, UserState>(
                    builder: (context, userState) {
                      if (userState is UserLoaded) {
                        return ListView(
                          children:  [
                            userState.cartProducts.isNotEmpty ? Column(
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: userState.cartProducts.length,
                                    itemBuilder: (context, index) {
                                      final cartProductId = userState.cartProducts[index].productId;

                                      final product = allProducts.firstWhere(
                                            (product) => product.productId == cartProductId,
                                        orElse: () => Product(
                                          productId: -1,
                                          name: "Продукт не найден",
                                          sellerId: "",
                                          description: "",
                                          price: 0,
                                          images: [],
                                          reviewScore: 0,
                                          amountOfReviews: 0,
                                          tags: [],
                                        ),
                                      );

                                      return Column(
                                        children: [
                                          CartUiItem(product: product, apiService: apiService,),
                                          index != userState.cartProducts.length - 1
                                              ? Divider()
                                              : SizedBox.shrink()
                                        ],
                                      );
                                    }

                                ),
                                SizedBox(height: 20,),
                                CustomButton(
                                    padding: 0,
                                    onTap: () => navigateToOrderPage(context),
                                    splashColor: Colors.white.withValues(alpha: 0.1),
                                    highlightColor: Colors.white.withValues(alpha: 0.1),
                                    mainColor: Color(0xFF187A3F),
                                    extraShadow: false,
                                    width: screenWidth * 0.8,
                                    height: screenHeight * 0.045,
                                    text: "Оформить заказ",
                                    textColor: Colors.white,
                                    fontSize: 25,
                                    hasIcon: false
                                ),
                              ],
                            ) : Column(
                              children: [
                                SizedBox(height: 100,),
                                Text(
                                    "Корзина пуста",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20
                                  ),
                                ),
                                SizedBox(height: 100,),
                              ],
                            ),

                            SizedBox(height: 35,),

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  "Вы интересовались",
                                style: TextStyle(
                                  fontSize: 27.5
                                ),
                              ),
                            ),

                            SizedBox(height: 20,),

                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(8),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.825,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                              ),
                              itemCount: allProducts.length,
                              itemBuilder: (context, index) {
                                return ProductCard(product: allProducts[index], apiService: apiService,);
                              },
                            ),



                          ],
                        );

                      } else {
                        return SizedBox.shrink();
                      }
                    }
                )


                    : Text(
              "Войдите или зарегистрируйтесь,\nчтобы совершать покупки",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
              ),
            )
            ),
          );
        }
    );
  }
}