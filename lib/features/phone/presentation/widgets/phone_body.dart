import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:style_hub/features/phone/bloc/phone_bloc.dart';

import '../../../../core/components/phone_input_field.dart';

class PhoneBody extends StatefulWidget {
  const PhoneBody({super.key});

  @override
  State<PhoneBody> createState() => _PhoneBodyState();
}

class _PhoneBodyState extends State<PhoneBody> {
  String _phone = '';
  final PhoneBloc _bloc = PhoneBloc();

  void login() {
    _bloc.add(Login(context, phone: _phone));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneBloc, PhoneState>(
      bloc: _bloc,
      builder: (context, state) {
        return Center(
          child: SizedBox(
            width: 300.w,
            height: 200.h,
            child: Column(
              children: [
                PhoneInputField(
                  onSubmitted: login,
                  onPhoneValid: (phone) {
                    setState(() {
                      _phone = phone;
                    });
                  },
                ),
                TextButton(
                  onPressed: _phone.isNotEmpty ? login : null,
                  child: const Text('Продолжить'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
