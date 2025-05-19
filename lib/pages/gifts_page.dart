import 'package:flutter/material.dart';
import 'package:verstak/widgets/celebration_item.dart';

import '../api_service.dart';
import '../demo_celebrations.dart';
import '../demo_products.dart';
import '../widgets/product_card/product_card.dart';

class GiftsPage extends StatelessWidget {

  final ApiService apiService;

  const GiftsPage({
    super.key,
    required this.apiService
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Для каждого праздника свой подарок!",
              style: TextStyle(
                  fontSize: 30
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: DemoCelebrations.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CelebrationItem(celebration: DemoCelebrations[index]),
                  );
                },
              ),
            ),
            Divider(),
            Expanded(
                child: ListView(
                  children: [
                    GridView.builder(
                      shrinkWrap: true, // Add this
                      physics: NeverScrollableScrollPhysics(), // Add this
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.825,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: DemoProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: DemoProducts[index], apiService: apiService,);
                      },
                    ),
                  ],
                )
            )
          ],
        )
    );
  }
}