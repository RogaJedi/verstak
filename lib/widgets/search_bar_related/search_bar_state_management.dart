
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchResults extends SearchState {
  final List<Product> results;
  final String query;

  const SearchResults(this.results, this.query);
}

class SearchCubit extends Cubit<SearchState> {
  final List<Product> allProducts;

  SearchCubit({required this.allProducts}) : super(SearchInitial());

  void search(String query) {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final results = allProducts.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(SearchResults(results, query));
  }

  void clearSearch() {
    emit(SearchInitial());
  }
}
