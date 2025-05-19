import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../api_service.dart';
import '../product.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ApiService apiService;

  ProductsCubit({required this.apiService}) : super(ProductsInitial()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      emit(ProductsLoading());
      final products = await apiService.getProducts();
      final sellerIds = products.map((p) => p.sellerId).toSet();

      final Map<String, String> sellerNames = {};
      for (final sellerId in sellerIds) {
        sellerNames[sellerId] = await apiService.getSellerById(sellerId);
      }

      final enrichedProducts = products.map((product) {
        return product.copyWith(
            sellerName: sellerNames[product.sellerId]
        );
      }).toList();
      emit(ProductsLoaded(enrichedProducts));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}