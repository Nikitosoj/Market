import 'package:flutter/material.dart';

import 'widgets/phone_body.dart';

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhoneBody(),
    );
  }
}
