part of 'catalog_bloc.dart';

sealed class CatalogEvent extends Equatable {}

class LoadCatalog extends CatalogEvent {
  LoadCatalog({this.completer});
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
