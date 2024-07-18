part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {}

class PaymentStart extends PaymentEvent {
  final List<Product> productList;
  final String userId;
  final int totalPrice;
  final BuildContext context;

  PaymentStart(this.context,
      {required this.productList,
      required this.userId,
      required this.totalPrice});

  @override
  List<Object?> get props => [productList, userId, totalPrice];
}
