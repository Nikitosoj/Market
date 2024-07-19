part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {}

class PaymentStart extends PaymentEvent {
  final List<CartProductModel> cartProductList;
  final User user;
  final int totalPrice;
  final BuildContext context;

  PaymentStart(this.context,
      {required this.cartProductList,
      required this.user,
      required this.totalPrice});

  @override
  List<Object?> get props => [cartProductList, user, totalPrice];
}
