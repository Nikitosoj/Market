import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:style_hub/core/models/cart_product.dart';
import 'package:style_hub/features/cart/bloc/cart_bloc.dart';
import 'package:style_hub/main.dart';

import '../../../core/models/user.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentStart>(addPayment);
  }
  void addPayment(PaymentStart event, Emitter<PaymentState> state) async {
    final user = event.user;
    final productList =
        event.cartProductList.map((item) => item.product).toList();
    try {
      final payment = await firebase.addUserPayment(
          user.id, event.totalPrice, 'success', 'online');
      if (payment != null) {
        final orderResult =
            await firebase.addOrder(user.id, productList, payment);
        if (orderResult) {
          for (final item in event.cartProductList) {
            await firebase.deleteProductFromCart(item.id, user.id);
          }
          BlocProvider.of<CartBloc>(event.context)
              .add(LoadCart(userId: event.user.id));
          event.context.pop();
        }
      }
    } catch (e) {
      event.context.go('/error', extra: e);
    }
  }
}
