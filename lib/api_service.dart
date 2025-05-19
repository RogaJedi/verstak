import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verstak/product.dart';


class ApiService {
  final SupabaseClient _client = Supabase.instance.client;

  static const String _favoritesTable = 'favorite_product';

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

  Future<List<String>> getFavoriteIds() async {
    final response = await _client.from(_favoritesTable)
        .select('product_id')
        .eq('user_id', _client.auth.currentUser!.id);

    return (response as List).map((item) => item['product_id'] as String).toList();
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

}