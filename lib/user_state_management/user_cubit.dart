import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verstak/user_state_management/user_state.dart';

import '../api_service.dart';
import '../models/product.dart';
import '../models/user_profile.dart';
import '../product_loader/products_cubit.dart';

class UserCubit extends Cubit<UserState> {
  final ApiService apiService;
  final ProductsCubit productsCubit;

  UserCubit({
    required this.apiService,
    required this.productsCubit,
  }) : super(UserInitial());

  Future<void> loadUserData() async {
    try {
      emit(UserLoading());

      final userProfile = await apiService.getUserProfile();

      final favoriteIds = await apiService.getUserFavorites();
      final cartItems = await apiService.getUserCart();

      final updatedProfile = userProfile.copyWith(
        favoriteProductIds: favoriteIds,
        cartItems: cartItems,
      );

      final allProducts = (productsCubit.state as ProductsLoaded).products;

      final favoriteProducts = allProducts
          .where((product) => favoriteIds.contains(product.productId))
          .toList();

      final cartProductIds = cartItems.map((item) => item.productId).toSet();
      final cartProducts = allProducts
          .where((product) => cartProductIds.contains(product.productId))
          .toList();

      emit(UserLoaded(
        userProfile: updatedProfile,
        favoriteProducts: favoriteProducts,
        cartProducts: cartProducts,
      ));
      print("[[[[[[[[[[[[[[[[[[[[[[[[[[USER IS LOADED!!!]]]]]]]]]]]]]]]]]]]]]]]]]]");
    } catch (e, stackTrace) {
      print("[[[[[[[[USER ERROR!!!]]]]]]]] ${e.toString()}");
      print("Stack trace: $stackTrace");
      emit(UserError(e.toString()));
    }
  }

  Future<void> addToFavorites(int productId) async {
    if (state is UserLoaded) {
      try {
        final currentState = state as UserLoaded;

        await apiService.addToFavorites(productId);

        final updatedFavoriteIds = List<int>.from(
            currentState.userProfile.favoriteProductIds)
          ..add(productId);

        final allProducts = (productsCubit.state as ProductsLoaded).products;
        final product = allProducts.firstWhere((p) => p.productId == productId);

        final updatedFavorites = List<Product>.from(
            currentState.favoriteProducts)
          ..add(product);

        final updatedProfile = currentState.userProfile.copyWith(
          favoriteProductIds: updatedFavoriteIds,
        );
        emit(UserLoaded(
          userProfile: updatedProfile,
          favoriteProducts: updatedFavorites,
          cartProducts: currentState.cartProducts,
        ));
      } catch (e) {
        emit(UserError(e.toString()));
        emit(state);
      }
    }
  }

  Future<void> removeFromFavorites(int productId) async {
    if (state is UserLoaded) {
      try {
        final currentState = state as UserLoaded;

        await apiService.removeFromFavorites(productId);

        final updatedFavoriteIds = List<int>.from(
            currentState.userProfile.favoriteProductIds)
          ..remove(productId);

        final updatedFavorites = currentState.favoriteProducts
            .where((product) => product.productId != productId)
            .toList();

        final updatedProfile = currentState.userProfile.copyWith(
          favoriteProductIds: updatedFavoriteIds,
        );

        emit(UserLoaded(
          userProfile: updatedProfile,
          favoriteProducts: updatedFavorites,
          cartProducts: currentState.cartProducts,
        ));
      } catch (e) {
        emit(UserError(e.toString()));
        emit(state);
      }
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    if (state is UserLoaded) {
      try {
        final currentState = state as UserLoaded;

        await apiService.addToCart(productId, quantity);

        final existingCartItemIndex = currentState.userProfile.cartItems
            .indexWhere((item) => item.productId == productId);

        List<CartItem> updatedCartItems;

        if (existingCartItemIndex >= 0) {
          final existingItem = currentState.userProfile
              .cartItems[existingCartItemIndex];
          final updatedItem = existingItem.copyWith(
            quantity: existingItem.quantity + quantity,
          );

          updatedCartItems =
          List<CartItem>.from(currentState.userProfile.cartItems);
          updatedCartItems[existingCartItemIndex] = updatedItem;
        } else {
          updatedCartItems =
          List<CartItem>.from(currentState.userProfile.cartItems)
            ..add(CartItem(productId: productId, quantity: quantity));
        }

        final allProducts = (productsCubit.state as ProductsLoaded).products;
        final product = allProducts.firstWhere((p) => p.productId == productId);

        List<Product> updatedCartProducts;
        if (!currentState.userProfile.cartItems.any((item) =>
        item.productId == productId)) {
          updatedCartProducts = List<Product>.from(currentState.cartProducts)
            ..add(product);
        } else {
          updatedCartProducts = currentState.cartProducts;
        }

        final updatedProfile = currentState.userProfile.copyWith(
          cartItems: updatedCartItems,
        );

        emit(UserLoaded(
          userProfile: updatedProfile,
          favoriteProducts: currentState.favoriteProducts,
          cartProducts: updatedCartProducts,
        ));
      } catch (e) {
        emit(UserError(e.toString()));
        emit(state);
      }
    }
  }

  Future<void> updateCartItemQuantity(int productId, int quantity) async {
    if (state is UserLoaded) {
      try {
        final currentState = state as UserLoaded;

        await apiService.updateCartItemQuantity(productId, quantity);

        final updatedCartItems = currentState.userProfile.cartItems.map((item) {
          if (item.productId == productId) {
            return item.copyWith(quantity: quantity);
          }
          return item;
        }).toList();

        final updatedProfile = currentState.userProfile.copyWith(
          cartItems: updatedCartItems,
        );

        emit(UserLoaded(
          userProfile: updatedProfile,
          favoriteProducts: currentState.favoriteProducts,
          cartProducts: currentState.cartProducts,
        ));
      } catch (e) {
        emit(UserError(e.toString()));
        emit(state);
      }
    }
  }

  Future<void> removeFromCart(int productId) async {
    if (state is UserLoaded) {
      try {
        final currentState = state as UserLoaded;

        await apiService.removeFromCart(productId);

        final updatedCartItems = currentState.userProfile.cartItems
            .where((item) => item.productId != productId)
            .toList();

        final updatedCartProducts = currentState.cartProducts
            .where((product) => product.productId != productId)
            .toList();

        final updatedProfile = currentState.userProfile.copyWith(
          cartItems: updatedCartItems,
        );

        emit(UserLoaded(
          userProfile: updatedProfile,
          favoriteProducts: currentState.favoriteProducts,
          cartProducts: updatedCartProducts,
        ));
      } catch (e) {
        emit(UserError(e.toString()));
        emit(state);
      }
    }
  }

  double getCartTotal() {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      double total = 0;

      for (var cartItem in currentState.userProfile.cartItems) {
        final product = currentState.cartProducts
            .firstWhere((p) => p.productId == cartItem.productId);
        total += product.price * cartItem.quantity;
      }

      return total;
    }
    return 0;
  }

  bool isProductFavorite(String productId) {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      return currentState.userProfile.favoriteProductIds.contains(productId);
    }
    return false;
  }

  bool isProductInCart(int productId) {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      return currentState.userProfile.cartItems
          .any((item) => item.productId == productId);
    }
    return false;
  }

  int getCartItemQuantity(int productId) {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      final cartItem = currentState.userProfile.cartItems
          .firstWhere(
            (item) => item.productId == productId,
        orElse: () => CartItem(productId: productId, quantity: 0),
      );
      return cartItem.quantity;
    }
    return 0;
  }
}