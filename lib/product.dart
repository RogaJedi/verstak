class Product {
  final String productId;
  final String name;
  final String seller;
  final String description;
  final int price;
  final String image;
  final double reviewScore;
  final int amountOfReviews;
  final String eventId;

  Product({
    required this.productId,
    required this.name,
    required this.seller,
    required this.description,
    required this.price,
    required this.image,
    required this.reviewScore,
    required this.amountOfReviews,
    required this.eventId
  });
}