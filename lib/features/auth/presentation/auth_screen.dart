import 'package:flutter/material.dart';

import 'widgets/body.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.phone});
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(phone: phone),
    );
  }
}
