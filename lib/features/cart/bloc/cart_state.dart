part of 'cart_bloc.dart';

sealed class CartState extends Equatable {}

final class CartInitial extends CartState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CartLoading extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  final List<Product> items;

  CartLoaded({required this.items});
  @override
  List<Object?> get props => [];
}

class CartLoadingFailure extends CartState {
  final String error;

  CartLoadingFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
