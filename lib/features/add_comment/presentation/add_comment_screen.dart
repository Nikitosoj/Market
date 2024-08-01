import 'package:flutter/material.dart';
import './widgets/body.dart';

class AddCommentScreen extends StatelessWidget {
  const AddCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Оставить отзыв')),
      body: Body(),
    );
  }
}
