import 'package:flutter/material.dart';

import '../api_service.dart';
import '../models/product.dart';

class OrderItem extends StatelessWidget {
  final Product product;
  final ApiService apiService;

  OrderItem({
    super.key,
    required this.product,
    required this.apiService,
  });

  Widget mainPart(String image, double height, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          child: Image.network(
            image,
            height: height,
            width: width,
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
    );
  }

  Widget menueItem(double width, double height) {
    return Container(
      color: Color(0xffEDEDED),
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Stack(
              children: [

                Column(
                  children: [
                    mainPart(product.images[0], screenHeight * 0.16, screenHeight * 0.19,),
                    menueItem(screenWidth * 0.9, screenHeight * 0.05),
                    menueItem(screenWidth * 0.9, screenHeight * 0.05),
                    menueItem(screenWidth * 0.9, screenHeight * 0.05),
                    Row(
                      children: [
                        Text("Товар"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Доставка"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Сумма к оплате"),
                      ],
                    ),
                  ],
                ),



                Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                    onTap: () {}, //
                    child: Icon(Icons.more_vert_rounded)
                )
            )
              ],
            ),
          ),
        ),
      ),
    );
  }
}