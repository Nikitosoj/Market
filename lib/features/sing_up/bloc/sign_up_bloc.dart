import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../auth_notifier.dart';
import '../../../core/models/user.dart';

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
    emit(SignUpLoading());
    try {
      final BuildContext context = event.context;
      final User? user = await User()
          .create(event.email, event.password, event.phone, event.seller);
      if (user != null) {
        Provider.of<AuthNotifier>(context, listen: false)
            .login(isSeller: user.seller, user: user);
        context.go('/catalog');
        emit(SignUpSuccess());
      } else {
        emit(const SignUpFailure(error: 'User creation failed.'));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something went wrong'),
        ));
      }
    } catch (error) {
      emit(SignUpFailure(error: error.toString()));
      ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
        content: Text('Something went wrong: ${error.toString()}'),
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
