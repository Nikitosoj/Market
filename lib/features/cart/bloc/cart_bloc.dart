import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_hub/core/models/cart_product.dart';

import '../../../main.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>(loadCartFromDb);
    on<DeleteItemFromCart>(deleteItemInDb);
  }
  void loadCartFromDb(LoadCart event, Emitter<CartState> emit) async {
    try {
      final items = await firebase.getUserCart(event.userId);
      emit(CartLoaded(items: items));
    } catch (e) {
      emit(CartLoadingFailure(error: e.toString()));
    }
  }

  void deleteItemInDb(DeleteItemFromCart event, Emitter<CartState> emit) async {
    try {
      final result = await firebase.deleteProductFromCart(
          event.cartProductId, event.userId);
      if (result) {
        final items = await firebase.getUserCart(event.userId);
        emit(CartLoaded(items: items));
      } else {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
          content: const Text('something went wrong'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
