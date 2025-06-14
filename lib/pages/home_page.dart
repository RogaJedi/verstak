import 'package:flutter/material.dart';
import 'package:verstak/widgets/big_card.dart';
import 'package:verstak/widgets/product_related/product_carousel.dart';

import '../api_service.dart';
import '../models/product.dart';
import '../widgets/product_related/product_card.dart';

class HomePage extends StatelessWidget {
  final List<Product> products;
  final ApiService apiService;

  const HomePage({
    super.key,
    required this.products,
    required this.apiService
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigCard(
                      picture: "https://cdn.mos.cms.futurecdn.net/TjtZ88nogxegChtJxdis3m-1200-80.jpg",
                      mainText: "Пасха на handmade",
                      subText: "Покупайте товары к празднику со скидкой",
                      onTap: () => print("tapped"),
                    ),

                    SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.02),
                      child: Text(
                        "Популярное",
                        style: TextStyle(
                            fontSize: 25
                        ),
                      ),
                    ),
                    ProductCarousel(
                      apiService: apiService,
                      products: products,
                    ),

                    SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.02),
                      child: Text(
                        "Подобрали для вас",
                        style: TextStyle(
                            fontSize: 25
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index], apiService: apiService,);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
