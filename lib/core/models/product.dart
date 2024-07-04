class Product {
  final int id;
  final String name;
  final String type;
  final String subType;
  final String description;
  final int price;
  final double rating;
  final List<String> sizes;
  final String sellerId;

  final int purchasesCount;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.type,
    required this.subType,
    required this.description,
    required this.price,
    required this.sizes,
    required this.sellerId,
    required this.rating,
    required this.purchasesCount,
    required this.stock,
  });
  factory Product.fromMap(Map<String, dynamic> map, List<String> sizes) {
    return Product(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      subType: map['sub_type'],
      description: map['description'],
      price: map['price'],
      sizes: sizes,
      sellerId: map['seller_id'],
      rating: ((map['rating'] as num).toDouble()),
      purchasesCount: map['purchases_count'],
      stock: map['stock'],
    );
  }
}
