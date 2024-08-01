import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:style_hub/core/models/product.dart';

import '../../../../auth_notifier.dart';
import '../../bloc/product_bloc.dart';

class Body extends StatefulWidget {
  const Body(this.product, {super.key});
  final Product product;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final ProductBloc _bloc;
  @override
  void initState() {
    _bloc = ProductBloc();
    _bloc.add(LoadProduct(
        productId: widget.product.id,
        userId: Provider.of<AuthNotifier>(context, listen: false).user!.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Product product = widget.product;
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is ProductLoaded) {
            print(state.canComment);
            return Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    height: 150.h,
                    child: Placeholder(),
                  ),
                  Text(product.name),
                  Text(product.rating.toStringAsFixed(2)),
                  Container(
                      height: 100.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.comments.length,
                          itemBuilder: (context, index) {
                            final comment = state.comments[index];
                            return Container(
                              padding: EdgeInsets.all(8),
                              width: 200.w,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      comment.comment,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        comment.userName,
                                        style: TextStyle(color: Colors.red),
                                      ))
                                ],
                              ),
                            );
                          })),
                  (state.canComment) ? Text('Can comment') : Container(),
                ],
              ),
            );
          } else if (state is ProductLoadingFailure) {
            return Center(
              child: Column(
                children: [
                  Text('error'),
                  TextButton(
                      onPressed: () {
                        _bloc.add(LoadProduct(
                            productId: product.id,
                            userId: Provider.of<AuthNotifier>(context,
                                    listen: false)
                                .user!
                                .id));
                      },
                      child: Text('Retry'))
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
