part of 'phone_bloc.dart';

sealed class PhoneEvent extends Equatable {}

final class Login extends PhoneEvent {
  final String phone;
  final BuildContext context;

  Login(this.context, {required this.phone});
  @override
  List<Object?> get props => [context, phone];
}
