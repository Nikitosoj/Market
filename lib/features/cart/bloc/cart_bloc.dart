import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>(getCartData);
  }
  void getCartData(LoadCart event, Emitter<CartState> emit) async {
    try {
      emit(CartLoaded(items: []));
    } catch (e) {
      emit(CartLoadingFailure(error: e.toString()));
    }
  }
}
