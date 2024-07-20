import 'package:flutter/material.dart';
import 'package:style_hub/core/models/product.dart';

import 'widgets/body.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0.0,
          title: Text(product.name)),
      body: Body(product),
    );
  }
}
