part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class InputValidationState extends SignUpState {
  final bool isButtonEnabled;

  const InputValidationState({required this.isButtonEnabled});

  @override
  List<Object> get props => [isButtonEnabled];
}
