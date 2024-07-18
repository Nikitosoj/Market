import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:style_hub/auth_notifier.dart';
import 'package:style_hub/core/models/user.dart';
import 'package:style_hub/features/payment/bloc/payment_bloc.dart';

import '../../../../core/models/product.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.productList});
  final List<Product> productList;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final PaymentBloc _bloc;
  late final List<Product> _productList;
  late final int _totalPrice;
  @override
  void initState() {
    _productList = widget.productList;
    _bloc = BlocProvider.of<PaymentBloc>(context);

    _totalPrice =
        _productList.map((product) => product.price).reduce((a, b) => a + b);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<AuthNotifier>(context).user!;
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
                  Row(),
                  Row(),
                  Row(),
                  Row(),
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
                        productList: _productList,
                        userId: _user.id));
                  },
                  child: Text('Купить'))
            ],
          ));
        });
  }
}
