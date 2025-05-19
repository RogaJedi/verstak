
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api_service.dart';
import 'PC_Event.dart';
import 'PC_State.dart';

class ProductCardBloc extends Bloc<ProductCardEvent, ProductCardState> {
  final ApiService apiService;

  ProductCardBloc({
    required this.apiService,
  }) : super(ProductCardState(favorite: false)) {
    on<InitializeFavoriteEvent>(_onInitialize);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<CheckFavoriteStatusEvent>(_onCheckFavoriteStatus);
  }

  Future<void> _onInitialize(
      InitializeFavoriteEvent event,
      Emitter<ProductCardState> emit,
      ) async {
    emit(state.copyWith(favorite: event.isFavorite));
  }

  Future<void> _onToggleFavorite(
      ToggleFavoriteEvent event,
      Emitter<ProductCardState> emit,
      ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      if (state.favorite) {
        await apiService.removeFromFavorites(event.productId);
      } else {
        await apiService.addToFavorites(event.productId);
      }

      emit(state.copyWith(
        favorite: !state.favorite,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onCheckFavoriteStatus(
      CheckFavoriteStatusEvent event,
      Emitter<ProductCardState> emit,
      ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final isFavorite = await apiService.isFavorite(event.productId);

      emit(state.copyWith(
        favorite: isFavorite,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

}