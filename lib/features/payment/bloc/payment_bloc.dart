import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/product.dart';
import '../service/payment_service.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentStart>(addPayment);
  }
  void addPayment(PaymentStart event, Emitter<PaymentState> state) async {
    final result =
        await insertPayment(event.userId, event.totalPrice, event.productList);
    if (result == null) {
      event.context.go('/catalog');
    } else {
      event.context.go('/error', extra: result);
    }
  }
}
