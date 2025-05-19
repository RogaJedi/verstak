import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int productId;
  final String name;
  final String seller;
  final String description;
  final int price;
  final List<String> images;
  final double reviewScore;
  final int amountOfReviews;
  final List<String> tags;

  const Product({
    required this.productId,
    required this.name,
    required this.seller,
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
      seller: json['seller_id'] as String,
      description: json['description'] as String,
      price: json['price_kp'] as int,
      images: (json['images'] as List).map((item) => item.toString()).toList(),
      reviewScore: (json['review_score'] as num).toDouble(),
      amountOfReviews: json['reviews_count'] as int,
      tags: (json['tags'] as List).map((item) => item.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'title': name,
      'seller_id': seller,
      'description': description,
      'price_kp': price,
      'images': images,
      'review_score': reviewScore,
      'reviews_count': amountOfReviews,
      'tags': tags,
    };
  }

  Product copyWith({
    int? productId,
    String? name,
    String? seller,
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
      seller: seller ?? this.seller,
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
    seller,
    description,
    price,
    images,
    reviewScore,
    amountOfReviews,
    tags,
  ];
}
