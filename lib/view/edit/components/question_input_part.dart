import 'package:flutter/material.dart';
import 'package:my_own_flashcards/model/db/data_base_manager.dart';
import 'package:my_own_flashcards/view_model/edit_screen_view_model.dart';
import 'package:provider/provider.dart';

class QuestionInputPart extends StatelessWidget {
  final Word? word;

  QuestionInputPart({this.word});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<EditScreenViewModel>();

    if (word != null) {
      Future(
        () => {
          viewModel.insertQuestionControllerText(word),
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          Text(
            "問題",
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            enabled: (word != null) ? false : true,
            controller: viewModel.questionController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0),
          ),
        ],
      ),
    );
  }
}
