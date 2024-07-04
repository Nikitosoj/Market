part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {}

final class ButtonPressed extends AuthEvent {
  final String password;
  final String email;

  final BuildContext context;

  ButtonPressed(this.context, {required this.password, required this.email});
  @override
  List<Object?> get props => [password, email, context];
}
