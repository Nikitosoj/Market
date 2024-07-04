import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/custom_form.dart';

class InputForms extends StatelessWidget {
  const InputForms({
    super.key,
    required TextEditingController phoneController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  })  : _phoneController = phoneController,
        _emailController = emailController,
        _passwordController = passwordController,
        _confirmPasswordController = confirmPasswordController;

  final TextEditingController _phoneController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomForm(
          label: 'Enter your phone number',
          controller: _phoneController,
        ),
        SizedBox(height: 20.h),
        CustomForm(
          label: 'Enter your email',
          controller: _emailController,
        ),
        SizedBox(height: 20.h),
        CustomForm(
          label: 'Enter your password',
          controller: _passwordController,
          obscure: true,
        ),
        SizedBox(height: 20.h),
        CustomForm(
          label: 'Confirm your password',
          controller: _confirmPasswordController,
          obscure: true,
        ),
      ],
    );
  }
}
