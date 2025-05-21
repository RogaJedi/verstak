import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verstak/api_service.dart';
import 'package:verstak/models/product.dart';
import 'package:verstak/user_state_management/user_cubit.dart';
import 'package:verstak/user_state_management/user_state.dart';

import '../../pages/product_page.dart';

class CartUiItem extends StatelessWidget {
  final Product product;
  final ApiService apiService;

  CartUiItem({
    super.key,
    required this.product,
    required this.apiService
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
        color: Colors.transparent,
        width: screenWidth,
        height: screenHeight * 0.18,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: Image.network(
                        product.images[0],
                        height: screenHeight * 0.16,
                        width: screenHeight * 0.19,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${product.sellerName}"),
                          Text("${product.name}")
                        ],
                      ),
                    )
                  ],
                ),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, userState) {
                    if (userState is UserLoaded) {
                      return Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: Text('Удаление товара'),
                                      content: Text('Вы уверены, что хотите удалить этот товар из корзины?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                          },
                                          child: Text('Отмена'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.read<UserCubit>().removeFromCart(product.productId);
                                            Navigator.of(dialogContext).pop();
                                          },
                                          child: Text('Удалить'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }, //
                              child: Icon(Icons.more_vert_rounded)
                          )
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }
                ),
                Positioned(
                    bottom: 0,
                    right: 6,
                    child: Text(
                        "${product.price} ₽",
                      style: TextStyle(
                        fontSize: 17.5
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}