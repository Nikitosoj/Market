import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:style_hub/features/catalog/presentation/widgets/product_widget.dart';

import '../../bloc/catalog_bloc.dart';

class CatalogBody extends StatefulWidget {
  const CatalogBody({super.key});

  @override
  State<CatalogBody> createState() => _CatalogBodyState();
}

class _CatalogBodyState extends State<CatalogBody> {
  final _bloc = CatalogBloc();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc.add(LoadCatalog());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 600) {
        final state = _bloc.state;
        if (state is CatalogLoaded) {
          final currentItemCount = state.items.length;
          _bloc.add(AddCatalogItems(currentItemCount, currentItemCount + 19));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final completer = Completer();
        _bloc.add(LoadCatalog(completer: completer));
        return completer.future;
      },
      child: BlocBuilder<CatalogBloc, CatalogState>(
        bloc: _bloc,
        builder: (context, state) {
          if ((state is CatalogLoaded) || (state is LoadingNextPage)) {
            final items = (state as dynamic).items;
            return GridView.custom(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.w,
                crossAxisSpacing: 10.w,
                childAspectRatio: 0.65,
                mainAxisSpacing: 10.h,
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ProductWidget(items[index]);
                },
                childCount: items.length,
              ),
            );
          }
          if (state is CatalogLoadingFailure) {
            return Center(
              child: Column(
                children: [
                  Text(state.error),
                  TextButton(
                    onPressed: () {
                      _bloc.add(LoadCatalog());
                    },
                    child: Text('Reload'),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
