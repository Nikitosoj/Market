import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../main.dart';

Future<bool> findPhone(String phone, BuildContext context) async {
  try {
    final response =
        await supabase.from('Users').select('phone').eq('phone', phone);
    if (response.isEmpty) {
      return false;
    } else {
      return true;
    }
  } catch (e) {
    log(e.toString());
    return false;
  }
}
