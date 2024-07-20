import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/product.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget(
    this.item, {
    super.key,
  });
  final Product item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/catalog/product', extra: item);
      },
      child: SizedBox(
        height: 220.h,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 140.h, child: Container()),
          Text('${item.price} rub'),
          Text(item.type, style: TextStyle(fontSize: 12.sp)),
          Text(item.name, style: TextStyle(fontSize: 12.sp)),
          Text(
            '${item.rating.toStringAsFixed(1)}, 2222 оценок',
            style: TextStyle(fontSize: 12.sp),
          ),
        ]),
      ),
    );
  }
}
