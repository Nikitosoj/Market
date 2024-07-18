import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:style_hub/core/models/user.dart';
import 'package:style_hub/features/cart/bloc/cart_bloc.dart';
import 'package:style_hub/features/cart/presentation/widgets/cart_product.dart';
import 'package:style_hub/features/cart/presentation/widgets/footer_widget.dart';

import '../../../../auth_notifier.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // final _bloc = CartBloc();

  late final CartBloc _bloc;
  late final User user;

  @override
  void initState() {
    _bloc = BlocProvider.of<CartBloc>(context);
    user = Provider.of<AuthNotifier>(context, listen: false).user!;
    _bloc.add(LoadCart(userId: user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is CartLoaded) {
            final items = state.items;
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: CartProduct(item: items[index], user: user),
                          );
                        }),
                  ),
                ),
                (items.isNotEmpty)
                    ? InkWell(
                        onTap: () {
                          context.go('/payment', extra: items);
                        },
                        child: FooterWidget(
                          amount: items.length,
                          totalPrice: items
                              .map((product) => product.price)
                              .reduce((a, b) => a + b),
                        ),
                      )
                    : Container()
              ],
            );
          }
          if (state is CartLoadingFailure) {
            return Center(
              child: Column(
                children: [
                  Text(state.error),
                  TextButton(
                    onPressed: () {
                      _bloc.add(LoadCart(userId: user.id));
                    },
                    child: const Text('Reload'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
