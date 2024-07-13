import 'package:style_hub/main.dart';

import '../../../core/models/product.dart';
import '../../../core/service/core_service.dart';

Future<List<Product>> getCartList(String userId) async {
  List<Map<String, dynamic>> result = [];
  final items =
      await supabase.from('Cart').select('product_id').eq('user_id', userId);
  for (final item in items) {
    final res = await supabase
        .from('Product')
        .select()
        .eq('id', item['product_id'])
        .single();
    result.add(res);
  }
  final productList = await getProductListFromId(result);
  return productList;
}

Future<bool> removeItem(String userId, int productId) async {
  try {
    await supabase
        .from('Cart')
        .delete()
        .eq('product_id', productId)
        .eq('user_id', userId);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
