import 'package:flutter/material.dart';
import 'package:my_own_flashcards/model/db/data_base_manager.dart';
import 'package:my_own_flashcards/view_model/edit_screen_view_model.dart';
import 'package:provider/provider.dart';

class AnswerInputPart extends StatelessWidget {
  final Word? word;

  AnswerInputPart({this.word});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<EditScreenViewModel>();

    if (word != null) {
      Future(
        () => {
          viewModel.insertAnswerControllerText(word),
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          Text(
            "こたえ",
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: viewModel.answerController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0),
          ),
        ],
      ),
    );
  }
}
