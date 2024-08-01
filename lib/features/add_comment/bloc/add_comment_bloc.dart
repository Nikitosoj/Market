import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_comment_event.dart';
part 'add_comment_state.dart';

class AddCommentBloc extends Bloc<AddCommentEvent, AddCommentState> {
  AddCommentBloc() : super(AddCommentInitial()) {
    on<AddCommentEvent>((event, emit) {});
  }
}
