import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_hub/core/models/cart_product.dart';

import '../../../core/models/comment.dart';
import '../service/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProduct>(getProductInfo);
    on<AddToCartButtonPressed>(addProductToCart);
  }
  Future<void> getProductInfo(
      LoadProduct event, Emitter<ProductState> emit) async {
    if (state is! ProductLoaded) {
      emit(ProductLoading());
    }
    // get comments from db max 5
    final commentList = await getComments(event.productId);
    final canComment = await checkCanComment(event.productId, event.userId);
    emit(ProductLoaded(comments: commentList, canComment: canComment));
  }

  Future<void> addProductToCart(
      AddToCartButtonPressed event, Emitter<ProductState> emit) async {}
}
