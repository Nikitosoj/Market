import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:style_hub/core/models/user.dart';
import 'package:style_hub/features/cart/bloc/cart_bloc.dart';
import 'package:style_hub/features/catalog/presentation/widgets/product_widget.dart';

import '../../../../auth_notifier.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CartBloc>(context);
    _user = Provider.of<AuthNotifier>(context, listen: false).user!;
    _bloc.add(LoadCart(userId: _user.id));
  }

  // final _bloc = CartBloc();
  late final CartBloc _bloc;
  late final User _user;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is CartLoaded) {
            final items = state.items;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 630.h,
                    child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ProductWidget(
                            items[index],
                          );
                        }),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Buy all'))
                ],
              ),
            );
          }
          if (state is CartLoadingFailure) {
            return Center(
              child: Column(
                children: [
                  Text(state.error),
                  TextButton(
                    onPressed: () {
                      _bloc.add(LoadCart(userId: _user.id));
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
