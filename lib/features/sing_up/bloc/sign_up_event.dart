part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {}

final class SignUpButtonPressed extends SignUpEvent {
  final String email;
  final String password;
  final String phone;
  final BuildContext context;
  final bool seller;

  SignUpButtonPressed(this.context,
      {required this.email,
      required this.password,
      required this.phone,
      required this.seller});
  @override
  List<Object?> get props => [context, email, password, phone, seller];
}

final class ValidateInputs extends SignUpEvent {
  final String password;
  final String confirmPassword;

  ValidateInputs({
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [password, confirmPassword];
}
