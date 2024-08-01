import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../auth_notifier.dart';
import '../../../main.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpButtonPressed>(signUpButton);
    on<ValidateInputs>(_validateInputs);
  }

  void signUpButton(
    SignUpButtonPressed event,
    Emitter<SignUpState> emit,
  ) async {
    final BuildContext context = event.context;
    try {
      final phone = event.phone;
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.email, password: event.password);
      if (userCredential.user != null) {
        final user = await firebase.createUserData(
            userCredential.user!.uid, event.email, phone, event.seller);
        if (user != null) {
          Provider.of<AuthNotifier>(context, listen: false)
              .login(isSeller: user.seller, user: user);
          context.go('/catalog');
          emit(SignUpSuccess());
        }
      }
    } catch (e) {
      emit(SignUpFailure(error: e.toString()));
      ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
        content: Text('Something went wrong: ${e.toString()}'),
      ));
    }
  }

  void _validateInputs(
    ValidateInputs event,
    Emitter<SignUpState> emit,
  ) {
    final isValidPassword = _isValidPassword(event.password);
    final doPasswordsMatch = event.password == event.confirmPassword;
    emit(InputValidationState(
        isButtonEnabled: isValidPassword && doPasswordsMatch));
  }

  bool _isValidPassword(String password) {
    final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passwordRegExp.hasMatch(password);
  }
}
