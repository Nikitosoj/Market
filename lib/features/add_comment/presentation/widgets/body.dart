import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_hub/features/add_comment/bloc/add_comment_bloc.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCommentBloc, AddCommentState>(
      builder: (context, state) {
        return Container();
      },
    );
  }
}
