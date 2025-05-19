import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verstak/pages/product_page.dart';

import '../../api_service.dart';
import '../../product.dart';
import 'PC_SM/PC_Bloc.dart';
import 'PC_SM/PC_Event.dart';
import 'PC_SM/PC_State.dart';

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
        builder: (context) => ProductPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (context) => ProductCardBloc(
          apiService: apiService,
        )..add(CheckFavoriteStatusEvent(productId: product.productId)),
        child: GestureDetector(
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
                    SizedBox(height: 2,),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.045, right: screenWidth * 0.045),
                      child: SizedBox(
                        height: screenHeight * 0.045,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - screenWidth * 0.09,
                            child: Text(
                              product.name,
                              style: const TextStyle(fontSize: 40),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.045),
                          child: SizedBox(
                            height: screenHeight * 0.02,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - screenWidth * 0.5,
                                child: Text(
                                  "${product.price} P",
                                  style: const TextStyle(fontSize: 40,),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: screenWidth * 0.045),
                            child: SizedBox(
                              height: screenHeight * 0.02,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width - screenWidth * 0.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.star, color: Color(0xFFf1c232), size: screenWidth * 0.037,),
                                      Text(
                                        "${product.reviewScore}",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ),
                      ],
                    )
                  ],
                ),
                Positioned(
                  top: 1,
                  right: 1,
                  child: BlocBuilder<ProductCardBloc, ProductCardState>(
                    builder: (context, state) {

                      return IconButton(
                        icon: Icon(
                          state.favorite ? Icons.favorite : Icons.favorite_border,
                          color: state.favorite ? Color(0xFFFF6183) : Colors.white,
                        ),
                        onPressed: () {
                          context.read<ProductCardBloc>().add(
                            ToggleFavoriteEvent(productId: product.productId),
                          );

                          if (state.error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error!)),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}