import 'package:flutter/material.dart';
import 'package:verstak/api_service.dart';
import 'package:verstak/widgets/order_item.dart';

import '../models/product.dart';

class OrderPage extends StatelessWidget {
  final List<Product> products;
  final ApiService apiService;

  OrderPage({
    super.key,
    required this.products,
    required this.apiService
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xFF187A3F),
      ),
      body: Center(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {

              return Column(
                children: [
                  OrderItem(product: products[index], apiService: apiService,),
                  index != products.length - 1
                      ? Divider()
                      : SizedBox.shrink()
                ],
              );
            }

        ),
      ),
    );
  }
}