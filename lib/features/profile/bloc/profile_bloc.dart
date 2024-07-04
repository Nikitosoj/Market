import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../auth_notifier.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<EditButtonPressed>(changeName);
  }
  void changeName(
    EditButtonPressed event,
    Emitter<ProfileState> emit,
  ) async {
    final TextEditingController textController = TextEditingController();
    final BuildContext context = event.context;
    final user = Provider.of<AuthNotifier>(context, listen: false).user!;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter your nickname'),
          content: TextField(
            controller: textController,
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                if (textController.text != '') {
                  await user.update(name: textController.text);
                  emit(ProfileUpdated());
                }
                Navigator.of(context).pop(textController.text);
              },
            ),
          ],
        );
      },
    );
    emit(ProfileInitial());
  }
}
