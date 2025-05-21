import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verstak/models/product.dart';

import 'models/user_profile.dart';


class ApiService {
  final SupabaseClient _client = Supabase.instance.client;

  static const String _favoritesTable = 'favorite_product';

  Future<UserProfile> getUserProfile() async {
    final response = await _client
        .from('users')
        .select()
        .eq('id', _client.auth.currentUser!.id,)
        .single();

    return UserProfile(
      id: response['id'],
      name: response['name'],
      email: response['email'],
    );
  }

  Future<List<int>> getUserFavorites() async {
    final response = await _client
        .from('favorite_product')
        .select('product_id')
        .eq('user_id', _client.auth.currentUser!.id,);

    return List<int>.from(response.map((item) => item['product_id']));
  }

  Future<List<CartItem>> getUserCart() async {
    final response = await _client
        .from('user_cart')
        .select('product_id, quantity')
        .eq('user_id', _client.auth.currentUser!.id,);

    return response.map<CartItem>((item) => CartItem(
      productId: item['product_id'],
      quantity: item['quantity'],
    )).toList();
  }

  Future<void> addToCart(int productId, int quantity) async {
    final existing = await _client
        .from('user_cart')
        .select()
        .match({'user_id': _client.auth.currentUser!.id, 'product_id': productId});

    if (existing.isEmpty) {
      await _client.from('user_cart').insert({
        'user_id': _client.auth.currentUser!.id,
        'product_id': productId,
        'quantity': quantity,
      });
    } else {
      await _client
          .from('user_cart')
          .update({'quantity': existing[0]['quantity'] + quantity})
          .match({'user_id': _client.auth.currentUser!.id, 'product_id': productId});
    }
  }

  Future<void> updateCartItemQuantity(int productId, int quantity) async {
    await _client
        .from('user_cart')
        .update({'quantity': quantity})
        .match({'user_id': _client.auth.currentUser!.id, 'product_id': productId});
  }

  Future<void> removeFromCart(int productId) async {
    await _client
        .from('user_cart')
        .delete()
        .match({'user_id': _client.auth.currentUser!.id, 'product_id': productId});
  }

  Future<void> addToFavorites(int productId) async {
    await _client.from(_favoritesTable).insert({
      'user_id': _client.auth.currentUser!.id,
      'product_id': productId,
    });
  }

  Future<void> removeFromFavorites(int productId) async {
    await _client.from(_favoritesTable)
        .delete()
        .match({
      'user_id': _client.auth.currentUser!.id,
      'product_id': productId,
    });
  }

  Future<bool> isFavorite(int productId) async {
    final response = await _client.from(_favoritesTable)
        .select()
        .match({
      'user_id': _client.auth.currentUser!.id,
      'product_id': productId,
    });

    return (response as List).isNotEmpty;
  }

  Future<void> clearFavorites() async {
    await _client.from(_favoritesTable)
        .delete()
        .eq('user_id', _client.auth.currentUser!.id);
  }

  Future<List<Product>> getProducts() async {
    final response = await _client.from('product').select();

    return (response as List)
        .map((item) => Product.fromJson(item))
        .toList();
  }

  Future<Product?> getProductById(int productId) async {
    final response = await _client
        .from('product')
        .select()
        .eq('product_id', productId)
        .maybeSingle();

    if (response == null) return null;
    return Product.fromJson(response);
  }

  Future<List<Product>> getProductsByTag(String tag) async {
    final response = await _client
        .from('product')
        .select()
        .contains('tags', [tag]);
    return (response as List)
        .map((item) => Product.fromJson(item))
        .toList();
  }

  Future<String> getSellerById(String id) async {
    try {
      final response = await _client
          .from('seller')
          .select('display_name')
          .eq('user_id', id)
          .maybeSingle();

      if (response == null) return "Продавец не найден";

      return response['display_name'] as String;
    } catch (e) {
      print('Err: $e');
      return "Err";
    }
  }

}