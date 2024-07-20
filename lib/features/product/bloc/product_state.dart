part of 'product_bloc.dart';

sealed class ProductState extends Equatable {}

final class ProductInitial extends ProductState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  final List<CommentModel> comments;
  final bool canComment;

  ProductLoaded({required this.comments, required this.canComment});
  @override
  List<Object?> get props => [comments, canComment];
}

class ProductLoadingFailure extends ProductState {
  @override
  List<Object?> get props => [];
}
