import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../auth_notifier.dart';
import '../../../main.dart';

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
    // final user = await checkUserData(email, password);
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        final readyUser = await firebase.getUserData(user.uid, user.email!);
        if (readyUser != null) {
          Provider.of<AuthNotifier>(context, listen: false)
              .login(isSeller: readyUser.seller, user: readyUser);
          // хранить сессию
          context.go('/catalog');
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: check email or your password'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message ?? 'Произошла непредвиденная ошибка'),
        ));
      }
    }

    // if () {
    //   Provider.of<AuthNotifier>(context, listen: false)
    //       .login(isSeller: user.seller, user: user);
    //   // хранить сессию
    //   context.go('/catalog');
    // }
  }
}
