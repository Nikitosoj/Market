import 'package:flutter/material.dart';

import '../../../core/models/product.dart';
import 'widgets/body.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.productList});
  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Оплата')),
      body: Body(productList: productList),
    );
  }
}
