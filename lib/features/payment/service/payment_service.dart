import 'package:style_hub/core/models/cart_product.dart';

import '../../../core/models/product.dart';
import '../../../main.dart';

Future<String?> buyProductList(
    String userId, int totalPrice, List<CartProductModel> productList) async {
  final productIds = productList.map((item) => item.product.id).toList();
  final productPrice = productList.map((item) => item.product.price).toList();
  final sizeNames = productList.map((item) => item.sizeSelected).toList();
  try {
    final result = await supabase
        .from('Payment')
        .insert({
          'user_id': userId,
          'payment_type': 'sber',
          'payment_method': 'test',
          'price': totalPrice
        })
        .select()
        .single();
    for (int i = 0; i < productIds.length; i++) {
      final sizeId = await supabase
          .from('Sizes')
          .select('id')
          .eq('name', sizeNames[i])
          .single();
      await supabase.from('Orders').insert({
        'user_id': userId,
        'product_id': productIds[i],
        'price': productPrice[i], // потом умножать на кол-во
        'quantity': 1,
        'payment_id': result['id'],
        'size_id': sizeId['id'],
      });
    }
  } catch (e) {
    print(e);
    return e.toString();
  }
  return null;
}

Future<void> clearUserCart(String userId, List<Product> productList) async {
  final productIds = productList.map((product) => product.id).toList();
  for (final productId in productIds) {
    await supabase
        .from('Cart')
        .delete()
        .eq('user_id', userId)
        .eq('product_id', productId);
  }
}
