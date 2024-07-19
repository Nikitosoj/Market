import 'package:style_hub/core/models/product.dart';
import 'package:style_hub/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/service/core_service.dart';

Future<List<Product>> getCatalogList(int startIndex, int endIndex) async {
  // Получаем список продуктов
  final result =
      await supabase.from('Product').select().range(startIndex, endIndex);
  final productList = await getProductListFromId(result);
  return productList;
}

Future<bool> insertProductToCart(
    String userId, int productId, String sizeName) async {
  try {
    final result = await supabase
        .from('Cart')
        .select('quantity')
        .eq('user_id', userId)
        .eq('product_id', productId)
        .single();
    final int quantity = result['quantity'];
    await supabase
        .from('Cart')
        .update({'quantity': quantity + 1})
        .eq('user_id', userId)
        .eq('product_id', productId);
    return true;
  } catch (e) {
    if (e is PostgrestException && e.code == 'PGRST116') {
      await supabase.from('Cart').insert(
          {'product_id': productId, 'user_id': userId, 'size_name': sizeName});
      return true;
    } else {
      return false;
    }
  }
}
