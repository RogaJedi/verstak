import 'package:equatable/equatable.dart';

import '../models/product.dart';
import '../models/user_profile.dart';



abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserProfile userProfile;
  final List<Product> favoriteProducts;
  final List<Product> cartProducts;

  const UserLoaded({
    required this.userProfile,
    required this.favoriteProducts,
    required this.cartProducts,
  });

  @override
  List<Object?> get props => [userProfile, favoriteProducts, cartProducts];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}