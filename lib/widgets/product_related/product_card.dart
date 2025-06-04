import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verstak/pages/product_page.dart';
import 'package:verstak/user_state_management/user_cubit.dart';
import 'package:verstak/user_state_management/user_state.dart';

import '../../api_service.dart';
import '../../auth/auth_cubit.dart';
import '../../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ApiService apiService;

  const ProductCard({
    super.key,
    required this.product,
    required this.apiService,
  });

  void navigateToProductPage(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductPage(product: product, apiService: apiService,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => navigateToProductPage(context, product),
      child: Container(
        width: screenWidth * 0.45,
        height: screenHeight * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.network(
                    product.images[0],
                    height: screenHeight * 0.18,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.0275,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - screenWidth * 0.5,
                      child: Text(
                        "${product.price} ₽",
                        style: const TextStyle(fontSize: 20,),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - screenWidth * 0.09,
                    child: Text(
                      product.name,
                      style: const TextStyle(fontSize: 25),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
            BlocBuilder<AuthCubit, AppAuthState>(
                builder: (context, authState) {
                  return authState is AuthAuthenticated
                    ? Positioned(
                    top: 1,
                    right: 1,
                    child: BlocBuilder<UserCubit, UserState>(
                      builder: (context, userState) {
                        if (userState is UserLoaded) {

                          final isFavorite = userState.userProfile.favoriteProductIds.contains(product.productId);

                          return IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Color(0xFFFF6183) : Colors.white,
                            ),
                            onPressed: () {
                              if (isFavorite) {
                                context.read<UserCubit>().removeFromFavorites(product.productId);
                              } else {
                                context.read<UserCubit>().addToFavorites(product.productId);
                              }
                            },
                          );
                        } else {
                          return SizedBox.shrink();
                        }


                      },
                    ),
                  )
                  : SizedBox.shrink();
                }
            )

          ],
        ),
      ),
    );
  }
}