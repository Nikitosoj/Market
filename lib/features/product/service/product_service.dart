import 'package:style_hub/core/models/comment.dart';
import 'package:style_hub/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<CommentModel>> getComments(int productId) async {
  List<CommentModel> finalList = [];
  final result = await supabase
      .from('Reviews')
      .select()
      .eq('product_id', productId)
      .range(0, 5);
  for (final item in result) {
    try {
      final name = await supabase
          .from('Users')
          .select('name')
          .eq('id', item['user_id'])
          .single();
      finalList.add(CommentModel(
          userName: name['name'] ?? 'anon',
          stars: (item['stars'] as int).toDouble(),
          comment: item['comment']));
      print(name);
    } catch (e) {
      print(e);
    }
  }
  return finalList;
}

Future<bool> checkCanComment(int productId, String userId) async {
  try {
    await supabase
        .from('Reviews')
        .select()
        .eq('product_id', productId)
        .eq('user_id', userId)
        .single();
    return false;
  } catch (e) {
    if (e is PostgrestException && e.code == 'PGRST116') {
      try {
        await supabase
            .from('Orders')
            .select()
            .eq('user_id', userId)
            .eq('product_id', productId)
            .single();
        return true;
      } catch (e) {
        if (e is PostgrestException && e.code == 'PGRST116') {
          return false;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }
}
