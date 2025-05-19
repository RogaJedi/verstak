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
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}