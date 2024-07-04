import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sign_up_bloc.dart';
import 'widgets/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.phone});
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (_) => SignUpBloc(),
      child: Body(phone: phone),
    ));
  }
}
