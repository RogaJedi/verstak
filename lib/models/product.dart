import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int productId;
  final String name;
  final String sellerId;
  final String? sellerName;
  final String description;
  final int price;
  final List<String> images;
  final double reviewScore;
  final int amountOfReviews;
  final List<String> tags;

  const Product({
    required this.productId,
    required this.name,
    required this.sellerId,
    this.sellerName,
    required this.description,
    required this.price,
    required this.images,
    required this.reviewScore,
    required this.amountOfReviews,
    required this.tags,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['id'] as int,
      name: json['title'] as String,
      sellerId: json['seller_id'] as String,
      sellerName: json['seller_name'] as String?,
      description: json['description'] as String,
      price: json['price_kp'] as int,
      images: (json['images'] as List).map((item) => item.toString()).toList(),
      reviewScore: (json['review_score'] as num).toDouble(),
      amountOfReviews: json['reviews_count'] as int,
      tags: (json['tags'] as List).map((item) => item.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'id': productId,
      'title': name,
      'seller_id': sellerId,
      'description': description,
      'price_kp': price,
      'images': images,
      'review_score': reviewScore,
      'reviews_count': amountOfReviews,
      'tags': tags,
    };

    if (sellerName != null) {
      map['seller_name'] = sellerName as Object;
    }

    return map;
  }

  Product copyWith({
    int? productId,
    String? name,
    String? sellerId,
    String? sellerName,
    String? description,
    int? price,
    List<String>? images,
    double? reviewScore,
    int? amountOfReviews,
    List<String>? tags,
  }) {
    return Product(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
      reviewScore: reviewScore ?? this.reviewScore,
      amountOfReviews: amountOfReviews ?? this.amountOfReviews,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [
    productId,
    name,
    sellerId,
    sellerName,
    description,
    price,
    images,
    reviewScore,
    amountOfReviews,
    tags,
  ];
}

