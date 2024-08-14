class ProductModel {
  final int id;
  final String name;
  final double price;
  final double discountPercentage;
  final List<String> imageUrl;
  final String description;
  final double weight;
  final String category;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.discountPercentage,
    required this.imageUrl,
    required this.description,
    required this.weight,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']!,
      name: json['title']!,
      price: json['price']!.toDouble(),
      discountPercentage: json['discountPercentage']!.toDouble(),
      imageUrl: List<String>.from(json['images']!),
      description: json['description']!,
      weight: json['weight']!.toDouble(),
      category: json['category']!,
    );
  }

  double getDiscountedPrice() {
    try {
      return price - (price * discountPercentage / 100);
    }
    catch(e){
      return 0.0;
    }
  }
}
