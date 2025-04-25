import 'package:flutter/material.dart';
import 'package:verstak/demo_products.dart';
import 'package:verstak/widgets/big_card.dart';
import 'package:verstak/widgets/product_carousel.dart';

import '../api_service.dart';
import '../widgets/product_card/product_card.dart';

class HomePage extends StatelessWidget {
  final ApiService apiService;

  const HomePage({
    super.key,
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
                      products: DemoProducts,
                      apiService: apiService,
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
                      shrinkWrap: true, // Add this
                      physics: NeverScrollableScrollPhysics(), // Add this
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: DemoProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: DemoProducts[index], apiService: apiService,);
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

