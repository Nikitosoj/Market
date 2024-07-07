import 'package:style_hub/core/models/product.dart';
import 'package:style_hub/main.dart';

Future<List<Product>> getCatalogList(int startIndex, int endIndex) async {
  // Получаем список продуктов
  final productResult =
      await supabase.from('Product').select().range(startIndex, endIndex);
  final products = List<Map<String, dynamic>>.from(productResult);

  // Создаем пустой список для хранения продуктов
  List<Product> productList = [];

  for (var productMap in products) {
    final productId = productMap['id'];

    // Получаем список размеров для каждого продукта
    final sizeResult = await supabase
        .from('ProductSize')
        .select('size_id')
        .eq('product_id', productId);
    final sizeIds = List<int>.from(sizeResult.map((size) => size['size_id']));

    // Получаем имена размеров
    List<String> sizes = [];
    for (var sizeId in sizeIds) {
      final sizeResult =
          await supabase.from('Sizes').select('name').eq('id', sizeId).single();
      sizes.add(sizeResult['name']);
    }

    // Создаем объект Product и добавляем его в список
    productList.add(Product.fromMap(productMap, sizes));
  }

  return productList;
}

Future<bool> productToCart(String userId, int productId) async {
  try {
    await supabase
        .from('Cart')
        .insert({'product_id': productId, 'user_id': userId});
    return true;
  } catch (e) {
    return false;
  }
}
