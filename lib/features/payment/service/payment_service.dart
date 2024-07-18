import '../../../core/models/product.dart';
import '../../../main.dart';

Future<String?> insertPayment(
    String userId, int totalPrice, List<Product> productList) async {
  final productIds = productList.map((product) => product.id).toList();
  final productPrice = productList.map((product) => product.price).toList();
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
      await supabase.from('Orders').insert({
        'user_id': userId,
        'product_id': productIds[i],
        'price': productPrice[i], // потом умножать на кол-во
        'quantity': 1,
        'payment_id': result['id']
      });
    }
  } catch (e) {
    print(e);
    return e.toString();
  }
  return null;
}
