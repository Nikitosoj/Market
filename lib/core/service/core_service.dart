// here .."<<I>>".. add change user model with update in DB
import '../../main.dart';
import '../models/product.dart';

Future<List<Product>> getProductListFromId(
    List<Map<String, dynamic>> result) async {
  final products = List<Map<String, dynamic>>.from(result);
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
