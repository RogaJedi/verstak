import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String name;
  final String email;
  final List<int> favoriteProductIds;
  final List<CartItem> cartItems;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.favoriteProductIds = const [],
    this.cartItems = const [],
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    List<int>? favoriteProductIds,
    List<CartItem>? cartItems,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      favoriteProductIds: favoriteProductIds ?? this.favoriteProductIds,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object> get props => [id, name, email, favoriteProductIds, cartItems];
}

class CartItem extends Equatable {
  final int productId;
  final int quantity;

  const CartItem({
    required this.productId,
    required this.quantity,
  });

  CartItem copyWith({
    int? productId,
    int? quantity,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [productId, quantity];
}
