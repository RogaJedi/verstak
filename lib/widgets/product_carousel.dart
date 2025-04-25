import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:verstak/widgets/product_card/product_card.dart';
import '../api_service.dart';
import '../product.dart';

class ProductCarousel extends StatelessWidget {
  final List<Product> products;
  final ApiService apiService;

  const ProductCarousel({
    super.key,
    required this.products,
    required this.apiService,
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
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductCard(
                    product: products[index],
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

//using carousel slider
/*
class ProductCarousel extends StatelessWidget {
  final List<Product> products;
  final ApiService apiService;

  const ProductCarousel({
    required this.products,
    required this.apiService,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: products.length,
      itemBuilder: (context, index, realIndex) {
        return SizedBox(  // or Container
          width: 200,     // Your desired width
          height: 190,    // Your desired height
          child: ProductCard(
            product: products[index],
            apiService: apiService,
            onCardTap: () {
              // Your onTap logic
            },
          ),
        );
      },
      options: CarouselOptions(
        height: 300,
        viewportFraction: 0.8,
        enableInfiniteScroll: true,
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
 */

//() => print("Product ${products[index].productId} tapped"),