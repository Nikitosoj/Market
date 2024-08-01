part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {}

class AddToCartButtonPressed extends ProductEvent {
  final CartProductModel item;

  AddToCartButtonPressed({required this.item});
  @override
  List<Object?> get props => [item];
}

class LoadProduct extends ProductEvent {
  final String productId;
  final String userId;

  LoadProduct({required this.productId, required this.userId});
  @override
  List<Object?> get props => [productId, userId];
}
