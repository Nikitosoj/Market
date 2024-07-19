import 'package:flutter/material.dart';
import 'package:style_hub/core/models/cart_product.dart';
import 'widgets/body.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.productList});
  final List<CartProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Оплата')),
      body: Body(cartProductList: productList),
    );
  }
}
