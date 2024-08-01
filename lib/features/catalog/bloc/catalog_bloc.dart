import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:style_hub/features/cart/bloc/cart_bloc.dart';

import '../../../core/models/product.dart';
import '../../../main.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogInitial()) {
    on<LoadCatalog>(getCatalog);
    // on<AddCatalogItems>(addItems);
    on<AddToCartButton>(addToCartButtonPressed);
  }
  void getCatalog(LoadCatalog event, Emitter<CatalogState> emit) async {
    try {
      if (state is! CatalogLoaded) {
        emit(CatalogLoading());
      }
      final items = await firebase.getProductList();
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
  // void addItems(AddCatalogItems event, Emitter<CatalogState> emit) async {
  //   if (state is CatalogLoaded) {
  //     final currentState = state as CatalogLoaded;
  //     final currentItems = List<Product>.from(currentState.items);
  //     emit(LoadingNextPage(items: currentItems));
  //     try {
  //       final newItems = await getCatalogList(event.startIndex, event.endIndex)
  //           .timeout(const Duration(seconds: 5));
  //       newItems.sort((a, b) => b.rating.compareTo(a.rating));
  //       final updatedItems = currentItems + newItems;
  //       emit(CatalogLoaded(items: updatedItems));
  //     } catch (e) {
  //       emit(CatalogLoadingFailure(e.toString()));
  //     }
  //   }
  // }

  void addToCartButtonPressed(
      AddToCartButton event, Emitter<CatalogState> emit) async {
    final context = event.context;
    if (event.product.sizes.length > 1) {
      showBottom(context, event);
    } else {
      await tryAddToCart(event, context, 'Standard'); // dobavit enum
    }
  }

  Future<void> tryAddToCart(
      AddToCartButton event, BuildContext context, String sizeName) async {
    try {
      final result = await firebase.addProductToCart(
          event.product, event.userId, sizeName);
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successful add to cart '),
        ));
        BlocProvider.of<CartBloc>(context).add(LoadCart(userId: event.userId));
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

  Future<dynamic> showBottom(BuildContext context, AddToCartButton event) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            child: Wrap(children: [
              ...event.product.sizes.map((size) {
                return GestureDetector(
                  onTap: () async {
                    await tryAddToCart(event, context, size);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 60.h,
                    width: 140.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey[50],
                    ),
                    child: Center(
                      child: Text(
                        size,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ]),
          );
        });
  }
}
