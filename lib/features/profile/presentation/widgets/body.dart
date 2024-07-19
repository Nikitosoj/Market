import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../auth_notifier.dart';
import '../../bloc/profile_bloc.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // final _bloc = ProfileBloc();
  late final ProfileBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthNotifier>(context, listen: false).user!;
    return SafeArea(
      child: BlocProvider(
        create: (_) => ProfileBloc(),
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdated) {
              setState(() {});
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            bloc: _bloc,
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text(user.name ?? 'nickname'),
                      IconButton(
                          onPressed: () {
                            _bloc.add(EditButtonPressed(context: context));
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 32.sp,
                          )),
                    ],
                  ),
                  Text('${user.totalBuy ?? 0}'),
                  Text('email : ${user.email}'),
                  Text('phone : ${user.phone}')
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
