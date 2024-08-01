import 'product.dart';

class CartProductModel {
  final Product product;
  final String sizeSelected;
  final String id;

  CartProductModel(
      {required this.id, required this.product, required this.sizeSelected});
}
