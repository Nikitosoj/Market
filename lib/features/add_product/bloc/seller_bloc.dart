import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:style_hub/main.dart';

part 'seller_event.dart';
part 'seller_state.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {
  SellerBloc() : super(SellerInitial()) {
    on<AddProductButton>(addProduct);
  }
  void addProduct(
    AddProductButton event,
    Emitter<SellerState> emit,
  ) async {
    final BuildContext context = event.context;
    try {
      final readyMap = {
        'name': event.name,
        'type': event.type,
        'sub_type': event.subType,
        'price': event.price,
        'description': event.description,
        'stock': event.stock,
        'seller_id': event.sellerId,
        'rating': 0,
        'purchases_count': 0,
      };
      await firebase.addNewProduct(readyMap, [event.size]);
      context.go('/catalog');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
