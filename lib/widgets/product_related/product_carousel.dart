import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:verstak/widgets/product_related/product_card.dart';
import '../../api_service.dart';
import '../../models/product.dart';

class ProductCarousel extends StatelessWidget {
  final ApiService apiService;
  final List<Product> products;

  const ProductCarousel({
    super.key,
    required this.apiService,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductCard(
                    product: product,
                    apiService: apiService,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
            top: 0,
            bottom: 0,
            right: 2.5,
            child: SvgPicture.asset(
              'assets/arrow.svg',
              width: 17.5,
              height: 17.5,
            )
        )
      ],
    );
  }
}