import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:style_hub/core/models/cart_product.dart';
import 'package:style_hub/features/cart/bloc/cart_bloc.dart';

import '../../../core/models/user.dart';
import '../service/payment_service.dart';

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
    final newTotalbuy = event.totalPrice + (user.totalBuy ?? 0);
    final result =
        await buyProductList(user.id, event.totalPrice, event.cartProductList);

    await clearUserCart(user.id, productList);
    if (result == null) {
      await user.update(totalBuy: newTotalbuy);
      BlocProvider.of<CartBloc>(event.context)
          .add(LoadCart(userId: event.user.id));
      event.context.pop();
    } else {
      event.context.go('/error', extra: result);
    }
  }
}
