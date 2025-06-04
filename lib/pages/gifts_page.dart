import 'package:flutter/material.dart';
import 'package:verstak/widgets/celebration_item.dart';

import '../api_service.dart';
import '../demo_celebrations.dart';
import '../models/product.dart';
import '../widgets/gift_page_scroll_indicator.dart';
import '../widgets/product_related/product_card.dart';

class GiftsPage extends StatefulWidget {
  final ApiService apiService;
  final List<Product> products;

  const GiftsPage({
    super.key,
    required this.apiService,
    required this.products
  });

  @override
  _GiftsPageState createState() => _GiftsPageState();
}

class _GiftsPageState extends State<GiftsPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollPosition);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollPosition);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateScrollPosition() {
    if (_scrollController.position.maxScrollExtent > 0) {
      setState(() {
        _scrollPosition = _scrollController.offset / _scrollController.position.maxScrollExtent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Получаем ширину экрана для расчета ширины индикатора
    final screenWidth = MediaQuery.of(context).size.width;
    // Ширина индикатора - 20% от ширины экрана
    final indicatorWidth = screenWidth * 0.2;

    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            const Text(
              "Для каждого праздника свой подарок!",
              style: TextStyle(
                  fontSize: 30
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: 120,
              child: ListView.builder(
                controller: _scrollController, // Добавляем контроллер
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
            SizedBox(height: 2.5,),
            ScrollIndicator(
              width: screenWidth,
              indicatorWidth: indicatorWidth,
              position: _scrollPosition,
            ),
            SizedBox(height: 10,),
            Expanded(
                child: ListView(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.825,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: widget.products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: widget.products[index], apiService: widget.apiService);
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