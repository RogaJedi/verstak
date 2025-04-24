import 'package:flutter/material.dart';
import 'package:verstak/demo_products.dart';
import 'package:verstak/widgets/big_card.dart';
import 'package:verstak/widgets/product_carousel.dart';

import '../api_service.dart';

class HomePage extends StatelessWidget {
  final ApiService apiService;

  const HomePage({
    super.key,
    required this.apiService
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;

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
                        onTap: () => print("tapped"),
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
                    ProductCarousel(
                      products: DemoProducts,
                      apiService: apiService,
                      onTap: () => print("tapped"),
                    ),
                    // Add more widgets here as needed
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
