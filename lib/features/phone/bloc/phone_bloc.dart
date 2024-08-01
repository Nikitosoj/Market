import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../auth_notifier.dart';
import '../../../main.dart';

part 'phone_event.dart';
part 'phone_state.dart';

class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  PhoneBloc() : super(PhoneInitial()) {
    on<Login>(checkPhone);
  }

  Future checkPhone(
    Login event,
    Emitter<PhoneState> emit,
  ) async {
    BuildContext context = event.context;
    final String phone = event.phone;
    final response = await firebase.isUserExistsByPhone(phone);
    if (!response) {
      Provider.of<AuthNotifier>(context, listen: false).login(user: null);
      context.go('/signUp', extra: phone);
    } else {
      Provider.of<AuthNotifier>(context, listen: false).login(user: null);
      context.go(
        '/auth',
        extra: phone,
      );
    }
  }
}
