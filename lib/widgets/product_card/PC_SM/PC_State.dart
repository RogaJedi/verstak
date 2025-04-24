class ProductCardState {
  final bool favorite;
  final bool isLoading;
  final String? error;

  ProductCardState({
    this.favorite = false,
    this.isLoading = false,
    this.error,
  });

  ProductCardState copyWith({
    bool? favorite,
    bool? isLoading,
    String? error,
  }) {
    return ProductCardState(
      favorite: favorite ?? this.favorite,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}