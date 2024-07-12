import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget(
      {super.key, required this.amount, required this.totalPrice});
  final int amount;
  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(5)),
      height: 30.h,
      width: 350.w,
      child: Column(children: [
        const Text('К оформлению', style: TextStyle(fontSize: 10)),
        Text('$amount шт., $totalPrice р', style: const TextStyle(fontSize: 10))
      ]),
    );
  }
}
