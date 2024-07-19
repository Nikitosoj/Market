import 'package:style_hub/main.dart';

import '../../../core/models/cart_product.dart';
import '../../../core/service/core_service.dart';

Future<List<CartProductModel>> getCartList(String userId) async {
  List<Map<String, dynamic>> result = [];
  List<String> selectedSizes = [];
  List<CartProductModel> cartList = [];
  final items =
      await supabase.from('Cart').select('product_id').eq('user_id', userId);
  for (final item in items) {
    final res = await supabase
        .from('Product')
        .select()
        .eq('id', item['product_id'])
        .single();
    result.add(res);
    final size = await supabase
        .from('Cart')
        .select('size_name')
        .eq('product_id', item['product_id'])
        .eq('user_id', userId)
        .single();
    selectedSizes.add(size['size_name']);
  }
  final productList = await getProductListFromId(result);
  for (var i = 0; i < productList.length; i++) {
    cartList.add(CartProductModel(
        product: productList[i], sizeSelected: selectedSizes[i]));
  }
  return cartList;
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
