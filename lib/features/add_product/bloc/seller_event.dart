part of 'seller_bloc.dart';

sealed class SellerEvent extends Equatable {}

final class AddProductButton extends SellerEvent {
  final String name;
  final String type;
  final String subType;
  final double price;
  final String description;
  final String sellerId;
  final String size;
  final BuildContext context;

  final int stock;

  AddProductButton(this.context,
      {required this.name,
      required this.size,
      required this.type,
      required this.subType,
      required this.price,
      required this.description,
      required this.sellerId,
      required this.stock});
  @override
  List<Object?> get props =>
      [name, type, subType, price, description, sellerId, stock, context];
}
