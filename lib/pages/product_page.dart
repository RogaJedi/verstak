import 'package:flutter/material.dart';

import '../api_service.dart';
import '../product.dart';

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

            Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => print("add to cart"),
                          child: Text("Добавить в корзину")
                      ),
                      IconButton(
                          onPressed: () => print("liked"),
                          icon: Icon(Icons.favorite)
                      )
                    ],
                  ),
                )
            )
          ],
        )
    );
  }
}

/*
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

    return FutureBuilder<String>(
        future: apiService.getSellerById(product.seller),
        builder: builder
    );
  }
}

 */

/*
Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF187A3F),
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

              Text(product.seller),
              Text("${product.price}Р"),

              Divider(),
              Text(product.description)
            ],
          ),

          Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () => print("add to cart"),
                        child: Text("Добавить в корзину")
                    ),
                    IconButton(
                        onPressed: () => print("liked"),
                        icon: Icon(Icons.favorite)
                    )
                  ],
                ),
              )
          )
        ],
      )
    );
 */
