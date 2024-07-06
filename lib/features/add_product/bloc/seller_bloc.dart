import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:style_hub/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      // Вставка продукта и получение его ID
      Map<String, dynamic> productMap = await supabase
          .from('Product')
          .insert({
            'name': event.name,
            'type': event.type,
            'sub_type': event.subType,
            'price': event.price,
            'description': event.description,
            'stock': event.stock,
            'seller_id': event.sellerId,
          })
          .select()
          .single();

      int productId = productMap['id'];

      int sizeId;
      try {
        Map<String, dynamic> size = await supabase
            .from('Sizes')
            .select('id')
            .eq('name', event.size)
            .single();

        sizeId = size['id'];
      } catch (e) {
        if (e is PostgrestException && e.code == 'PGRST116') {
          Map<String, dynamic> sizeMap = await supabase
              .from('Sizes')
              .insert({'name': event.size})
              .select()
              .single();

          sizeId = sizeMap['id'];
        } else {
          rethrow;
        }
      }

      await supabase
          .from('ProductSize')
          .insert({'product_id': productId, 'size_id': sizeId});
      context.go('/catalog');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
