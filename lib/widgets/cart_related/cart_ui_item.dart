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
                          bottom: 0,
                          right: 6,
                          child: Container(
                            width: screenWidth * 0.475,
                            height: 20,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext dialogContext) {
                                              return AlertDialog(
                                                content: Container(
                                                  height: screenHeight * 0.1,
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            'Удалить товар?',
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
                                                                context.read<UserCubit>().removeFromCart(product.productId);
                                                                Navigator.of(dialogContext).pop();
                                                              },
                                                              child: Text(
                                                                  'Удалить',
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
                                        },
                                        child: Icon(Icons.delete)
                                    ),
                                    Icon(Icons.share)
                                  ],
                                ),
                                Text(
                                  "${product.price} ₽",
                                  style: TextStyle(
                                      fontSize: 17.5
                                  ),
                                ),
                              ],
                            ),
                          )
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
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
                              },
 */