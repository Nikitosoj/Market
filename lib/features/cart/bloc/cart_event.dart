part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {}

class LoadCart extends CartEvent {
  final String userId;

  LoadCart({required this.userId});
  @override
  List<Object?> get props => [userId];
}

class DeleteItemFromCart extends CartEvent {
  final BuildContext context;
  final String userId;
  final int productId;

  DeleteItemFromCart({
    required this.context,
    required this.userId,
    required this.productId,
  });
  @override
  List<Object?> get props => [userId, productId, context];
}
