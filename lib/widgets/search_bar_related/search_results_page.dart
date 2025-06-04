import 'package:flutter/material.dart';
import 'package:verstak/api_service.dart';

import '../../models/product.dart';
import '../product_related/product_card.dart';

class SearchResultsPage extends StatelessWidget {
  final List<Product> searchResults;
  final ApiService apiService;
  final String searchQuery;

  const SearchResultsPage({
    Key? key,
    required this.searchResults,
    required this.searchQuery,
    required this.apiService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Результаты поиска для "$searchQuery"',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        searchResults.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'Ничего не найдено',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
            : Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final product = searchResults[index];
              return ProductCard(product: product, apiService: apiService,);
            },
          ),
        ),
      ],
    );
  }
}
