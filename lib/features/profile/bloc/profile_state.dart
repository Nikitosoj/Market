part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {}

final class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileUpdated extends ProfileState {
  @override
  List<Object?> get props => [];
}
