import 'package:flutter/material.dart';
import 'package:style_hub/features/cart/presentation/widgets/body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: const Body(),
    );
  }
}
