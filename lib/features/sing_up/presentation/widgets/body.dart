import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:style_hub/core/styles/text_styles.dart';
import 'package:style_hub/features/sing_up/presentation/widgets/input_forms.dart';

import '../../bloc/sign_up_bloc.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.phone});

  final String phone;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isSeller = false;

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.phone;
    _passwordController.addListener(_onInputChange);
    _confirmPasswordController.addListener(_onInputChange);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onInputChange() {
    final signUpBloc = BlocProvider.of<SignUpBloc>(context);
    signUpBloc.add(ValidateInputs(
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    ));
  }

  void _register(BuildContext context) {
    final signUpBloc = BlocProvider.of<SignUpBloc>(context);
    signUpBloc.add(SignUpButtonPressed(
      context,
      email: _emailController.text,
      password: _passwordController.text,
      phone: _phoneController.text,
      seller: isSeller,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          // Отображение ошибки
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        final isButtonEnabled =
            state is InputValidationState && state.isButtonEnabled;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              Text('Create your account!', style: TextStyles.title),
              SizedBox(height: 50.h),
              InputForms(
                phoneController: _phoneController,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
              SizedBox(height: 20.h),
              ChoiceChip(
                label: const Text('Продавец'),
                selected: isSeller,
                onSelected: (value) {
                  setState(() {
                    isSeller = !isSeller;
                  });
                },
              ),
              Center(
                child: TextButton(
                  onPressed: isButtonEnabled ? () => _register(context) : null,
                  child: const Text('Register', style: TextStyle(fontSize: 24)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.go('/auth', extra: _phoneController.text);
                },
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        );
      },
    );
  }
}
