import 'package:flutter/material.dart';
import 'package:verstak/widgets/big_card.dart';
import 'package:verstak/widgets/product_carousel.dart';

import '../api_service.dart';
import '../product.dart';
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

    return FutureBuilder<List<Product>>(
        future: apiService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Пожалуйста подождите..."));
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Err: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products'));
          }

          final products = snapshot.data!;

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
                              childAspectRatio: 0.825,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
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
    );
  }
}
