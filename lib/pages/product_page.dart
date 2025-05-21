import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verstak/user_state_management/user_cubit.dart';
import 'package:verstak/widgets/custom_button.dart';

import '../api_service.dart';
import '../auth/auth_cubit.dart';
import '../models/product.dart';
import '../user_state_management/user_state.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  final ApiService apiService;

  const ProductPage({
    super.key,
    required this.product,
    required this.apiService
  });

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF187A3F),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                ClipRRect(
                  child: Image.network(
                    product.images[0],
                    height: screenHeight * 0.45,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.name),
                    Row(
                      children: [
                        Text("${product.reviewScore}"),
                        Icon(Icons.star, color: Color(0xFFf1c232), size: screenWidth * 0.037,),
                        Text("(${product.amountOfReviews})")
                      ],
                    )
                  ],
                ),

                Text(product.sellerName.toString()),
                Text("${product.price}Р"),

                Divider(),
                Text(product.description)
              ],
            ),

            BlocBuilder<AuthCubit, AppAuthState>(
                builder: (context, authState) {
                  return authState is AuthAuthenticated
                      ? BlocBuilder<UserCubit, UserState>(
                      builder: (context, userState) {
                        if (userState is UserLoaded) {
                          final isFavorite = userState.userProfile.favoriteProductIds.contains(product.productId);
                          final isInCart = userState.userProfile.cartItems.any((item) => item.productId == product.productId);

                          return Positioned(
                              bottom: 40,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isInCart
                                        ? CustomButton(
                                        padding: 0,
                                        onTap: () {},
                                        splashColor: Colors.white.withValues(alpha: 0.1),
                                        highlightColor: Colors.white.withValues(alpha: 0.1),
                                        mainColor: Colors.grey,
                                        extraShadow: true,
                                        width: screenWidth * 0.55,
                                        height: screenHeight * 0.045,
                                        text: "В корзине",
                                        textColor: Colors.white,
                                        fontSize: 20,
                                        hasIcon: false,
                                    )
                                        : CustomButton(
                                        padding: 0,
                                        onTap: () => context.read<UserCubit>().addToCart(product.productId, 1),
                                        splashColor: Colors.white.withValues(alpha: 0.1),
                                        highlightColor: Colors.white.withValues(alpha: 0.1),
                                        mainColor: Color(0xFF187A3F),
                                        extraShadow: true,
                                        width: screenWidth * 0.55,
                                        height: screenHeight * 0.045,
                                        text: "В корзину",
                                        textColor: Colors.white,
                                        fontSize: 20,
                                        hasIcon: false
                                    ),


                                    SizedBox(width: 15,),
                                    CircleAvatar(
                                      backgroundColor: Color(0xFF187A3F),
                                      radius: screenHeight * 0.0225,
                                      child: Center(
                                        child: IconButton(
                                            onPressed: () {
                                              if (isFavorite) {
                                                context.read<UserCubit>().removeFromFavorites(product.productId);
                                              } else {
                                                context.read<UserCubit>().addToFavorites(product.productId);
                                              }
                                            },
                                            icon: Icon(
                                                isFavorite? Icons.favorite : Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                          iconSize: 25,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                  }
                  )
                      : Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                            ),
                            width: screenWidth * 0.7,
                            child: Center(
                                child: Text(
                                    "Войдите или зарегистрируйтесь,\nчтобы совершать покупки",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    fontWeight: FontWeight.w300
                                  ),
                                )
                            ),

                                            ),
                        ),
                      );
                }
            )
          ],
        )
    );
  }
}