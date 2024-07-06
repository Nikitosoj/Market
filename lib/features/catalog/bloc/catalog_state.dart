part of 'catalog_bloc.dart';

sealed class CatalogState extends Equatable {}

final class CatalogInitial extends CatalogState {
  @override
  List<Object?> get props => [];
}

class CatalogLoading extends CatalogState {
  @override
  List<Object?> get props => [];
}

class CatalogLoaded extends CatalogState {
  final List<Product> items;

  CatalogLoaded({required this.items});
  @override
  List<Object?> get props => [items];
}

class CatalogLoadingFailure extends CatalogState {
  final String error;

  CatalogLoadingFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class LoadingNextPage extends CatalogState {
  final List<Product> items;
  LoadingNextPage({required this.items});

  @override
  List<Object?> get props => [items];
}
