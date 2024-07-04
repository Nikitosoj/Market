part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {}

final class EditButtonPressed extends ProfileEvent {
  final BuildContext context;

  EditButtonPressed({required this.context});
  @override
  List<Object?> get props => throw UnimplementedError();
}
