part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {}

final class PaymentInitial extends PaymentState {
  @override
  List<Object?> get props => throw [];
}

class PaymentConfirm extends PaymentState {
  @override
  List<Object?> get props => throw [];
}

class PaymentLoading extends PaymentState {
  @override
  List<Object?> get props => throw [];
}

class PaymentRejected extends PaymentState {
  @override
  List<Object?> get props => throw [];
}
