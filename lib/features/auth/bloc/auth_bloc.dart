import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:style_hub/features/auth/domain/service/service.dart';

import '../../../auth_notifier.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<ButtonPressed>(login);
  }
  void login(
    ButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    final BuildContext context = event.context;
    final password = event.password;
    final email = event.email.toLowerCase();
    final user = await checkUserData(email, password);

    if (user != null) {
      Provider.of<AuthNotifier>(context, listen: false)
          .login(isSeller: user.seller, user: user);
      // хранить сессию
      context.go('/catalog');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: check email or your password'),
      ));
    }
  }
}
