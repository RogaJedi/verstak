abstract class ProductCardEvent {}

class ToggleFavoriteEvent extends ProductCardEvent {
  final String productId;

  ToggleFavoriteEvent({required this.productId});
}

class InitializeFavoriteEvent extends ProductCardEvent {
  final bool isFavorite;

  InitializeFavoriteEvent({required this.isFavorite});
}

class CheckFavoriteStatusEvent extends ProductCardEvent {
  final String productId;

  CheckFavoriteStatusEvent({required this.productId});
}