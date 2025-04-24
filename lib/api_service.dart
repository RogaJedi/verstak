abstract class ApiService {
  Future<void> addToFavorites(String productId);
  Future<void> removeFromFavorites(String productId);
  Future<List<String>> getFavoriteIds();

  Future<void> updateStatus(String orderId, int status);
  Future<int> getStatus(String orderId);
}

class MockApiService implements ApiService {

  final Set<String> _favoriteIds = {};

  final Map<String, int> _orderStatus = {};


  @override
  Future<void> addToFavorites(String productId) async {
    _favoriteIds.add(productId);
  }

  @override
  Future<void> removeFromFavorites(String productId) async {
    _favoriteIds.remove(productId);
  }

  @override
  Future<List<String>> getFavoriteIds() async {
    return _favoriteIds.toList();
  }

  Future<bool> isFavorite(String productId) async {
    return _favoriteIds.contains(productId);
  }

  Future<void> clearFavorites() async {
    _favoriteIds.clear();
  }

  @override
  Future<void> updateStatus(String orderId, int status) async {
    _orderStatus[orderId] = status;
  }

  @override
  Future<int> getStatus(String orderId) async {
    return _orderStatus[orderId] ?? 0;
  }
}