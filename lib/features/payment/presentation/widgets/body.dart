import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:style_hub/auth_notifier.dart';
import 'package:style_hub/features/payment/bloc/payment_bloc.dart';

import '../../../../core/models/cart_product.dart';
import '../../../../core/models/product.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.cartProductList});
  final List<CartProductModel> cartProductList;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final PaymentBloc _bloc;
  late final List<CartProductModel> _cartProductList;
  late final int _totalPrice;
  late List<Product> _productList;
  @override
  void initState() {
    _cartProductList = widget.cartProductList;
    _bloc = BlocProvider.of<PaymentBloc>(context);
    _productList = [];
    _cartProductList.map((item) => _productList.add(item.product));
    _totalPrice = _cartProductList
        .map((item) => item.product.price)
        .reduce((a, b) => a + b);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context).user!;
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          return SafeArea(
              child: Column(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Кол-во товаров: '),
                      Text(_productList.length.toString())
                    ],
                  ),
                  Row(),
                  Row(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Общая цена: '),
                      Text(_totalPrice.toString())
                    ],
                  ),
                  Container(
                    height: 150.h,
                    child: ListView.builder(
                        itemCount: _productList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Placeholder();
                        }),
                  )
                ]),
              ),
              TextButton(
                  onPressed: () {
                    _bloc.add(PaymentStart(context,
                        totalPrice: _totalPrice,
                        cartProductList: _cartProductList,
                        user: user));
                  },
                  child: Text('Купить'))
            ],
          ));
        });
  }
}
