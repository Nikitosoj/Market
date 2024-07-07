part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {}

class LoadCart extends CartEvent {
  final String userId;

  LoadCart({required this.userId});
  @override
  List<Object?> get props => [userId];
}
