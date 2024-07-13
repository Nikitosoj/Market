import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:style_hub/core/models/product.dart';

import '../../../../core/models/user.dart';
import '../../bloc/cart_bloc.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({required this.item, required this.user, super.key});
  final Product item;
  final String storage = 'Crimea';
  final User user;

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                BlocProvider.of<CartBloc>(context).add(DeleteItemFromCart(
                  context: context,
                  userId: user.id,
                  productId: item.id,
                ));
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              icon: Icons.delete,
              label: 'Удалить',
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: const Color.fromARGB(255, 250, 243, 32),
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              icon: Icons.favorite,
              label: 'Избранное',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // context.go -> product screen
                  },
                  child: Row(
                    children: [
                      SizedBox(
                          height: 150.h,
                          width: 100.w,
                          child: const Placeholder()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name,
                              overflow: TextOverflow.ellipsis, maxLines: 3),
                          Text('Артикул: ${item.id.toString()}'),
                          Text('Склад: $storage'),
                          // SizedBox(
                          //   height: 40.h,
                          //   child: ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //       itemCount: item.sizes.length,
                          //       itemBuilder: (context, index) {
                          //         return Container(
                          //           height: 30.h,
                          //           width: 40.w,
                          //           decoration: BoxDecoration(
                          //               borderRadius:
                          //                   BorderRadius.circular(10)),
                          //           child: Text(item.sizes[index]),
                          //         );
                          //       }),
                          // ),
                          const Row(
                            children: [
                              // here will be button to increment amount of product
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(children: [
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          'Цена со скидкой: ${item.price}',
                        ),
                        Text('${item.price} р')
                      ])),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Купить'),
                  )
                ])
              ],
            ),
          ),
        ));
  }
}
