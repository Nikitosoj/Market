import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:style_hub/core/styles/text_styles.dart';

import '../../../../core/components/custom_form.dart';
import '../../bloc/auth_bloc.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _bloc = AuthBloc();

  @override
  void initState() {
    _emailController = TextEditingController(text: 'ssss@gmail.com');
    _passwordController = TextEditingController(text: 'aaaaaa');
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: _bloc,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              Text('Hey there!', style: TextStyles.title),
              Text(
                'Welcome back,please use ur phone number, email and password to log in.',
                style: TextStyles.secondaryGray,
              ),
              SizedBox(height: 100.h),
              CustomForm(
                  label: 'Enter your email', controller: _emailController),
              SizedBox(height: 20.h),
              CustomForm(
                  label: 'Enter your password',
                  controller: _passwordController,
                  obscure: true),
              SizedBox(height: 20.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    _bloc.add(ButtonPressed(context,
                        email: _emailController.text,
                        password: _passwordController.text));
                  },
                  child: Text('Login', style: TextStyle(fontSize: 24)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.go('/signUp', extra: '');
                },
                child: Text('У вас нет аккаунта? Зарегестрироваться'),
              )
            ],
          ),
        );
      },
    );
  }
}
