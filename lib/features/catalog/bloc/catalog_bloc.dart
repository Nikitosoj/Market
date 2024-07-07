import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:style_hub/features/catalog/service/service.dart';

import '../../../core/models/product.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogInitial()) {
    on<LoadCatalog>(getCatalog);
    on<AddCatalogItems>(addItems);
    on<AddToCartButton>(addToCart);
  }
  void getCatalog(LoadCatalog event, Emitter<CatalogState> emit) async {
    try {
      if (state is! CatalogLoaded) {
        emit(CatalogLoading());
      }
      final items =
          await getCatalogList(0, 19).timeout(const Duration(seconds: 5));
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

// объединить это красиво
  void addItems(AddCatalogItems event, Emitter<CatalogState> emit) async {
    if (state is CatalogLoaded) {
      final currentState = state as CatalogLoaded;
      final currentItems = List<Product>.from(currentState.items);
      emit(LoadingNextPage(items: currentItems));
      try {
        final newItems = await getCatalogList(event.startIndex, event.endIndex)
            .timeout(const Duration(seconds: 5));
        newItems.sort((a, b) => b.rating.compareTo(a.rating));
        final updatedItems = currentItems + newItems;
        emit(CatalogLoaded(items: updatedItems));
      } catch (e) {
        emit(CatalogLoadingFailure(e.toString()));
      }
    }
  }

  void addToCart(AddToCartButton event, Emitter<CatalogState> emit) async {
    final context = event.context;
    try {
      final result = await productToCart(event.userId, event.productId);
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successful add to cart '),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something went wrong'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
