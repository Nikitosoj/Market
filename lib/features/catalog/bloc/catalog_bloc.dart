import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:style_hub/features/catalog/service/service.dart';

import '../../../core/models/product.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogInitial()) {
    on<LoadCatalog>(getCatalog);
  }
  void getCatalog(LoadCatalog event, Emitter<CatalogState> emit) async {
    try {
      if (state is! CatalogLoaded) {
        emit(CatalogLoading());
      }
      final items = await getCatalogList().timeout(const Duration(seconds: 5));
      items.sort((a, b) => b.rating.compareTo(a.rating));
      emit(CatalogLoaded(items: items));
    } on TimeoutException {
      emit(CatalogLoadingFailure(
          'Timeout error, check your internet connection'));
    } catch (e) {
      emit(CatalogLoadingFailure(e.toString()));
    } finally {
      event.completer?.complete();
    }
  }
}
