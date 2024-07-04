part of 'phone_bloc.dart';

sealed class PhoneState extends Equatable {
  const PhoneState();
  
  @override
  List<Object> get props => [];
}

final class PhoneInitial extends PhoneState {}
