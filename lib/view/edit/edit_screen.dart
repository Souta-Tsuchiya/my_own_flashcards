import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_own_flashcards/model/db/data_base_manager.dart';
import 'package:my_own_flashcards/util/constant.dart';
import 'package:my_own_flashcards/view/word_list/word_list_screen.dart';
import 'package:my_own_flashcards/view_model/edit_screen_view_model.dart';
import 'package:provider/provider.dart';

import 'components/answer_input_part.dart';
import 'components/question_input_part.dart';

class EditScreen extends StatelessWidget {
  final EditScreenType editScreenType;
  final Word? word;

  EditScreen({
    required this.editScreenType,
    this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (editScreenType == EditScreenType.ADD) ? Text("新しい単語の追加") : Text("登録した単語の修正"),
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () => _openWordListScreen(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            tooltip: "登録",
            onPressed: (editScreenType == EditScreenType.ADD)
                ? () => _insertWord(context)
                : () => _changeInsertWord(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24.0,
            ),
            Center(
              child: Text(
                "問題と答えを入力して「登録」ボタンを押してください",
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            QuestionInputPart(word: word),
            SizedBox(
              height: 24.0,
            ),
            AnswerInputPart(word: word),
          ],
        ),
      ),
    );
  }

  _openWordListScreen(BuildContext context) {
    final viewModel = context.read<EditScreenViewModel>();
    viewModel.textEditingControllerClear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => WordListScreen(),
      ),
    );
  }

  _insertWord(BuildContext context) async {
    final viewModel = context.read<EditScreenViewModel>();
    if (viewModel.questionController.text == "" || viewModel.answerController.text == "") {
      Fluttertoast.showToast(
        msg: "問題と答えの両方が入力された状態にしてください",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }
    ;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text("登録"),
        content: Text("登録しますか?"),
        actions: [
          TextButton(
            child: Text("はい"),
            onPressed: () async {
              await viewModel.insertWord();
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text("いいえ"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  _changeInsertWord(BuildContext context) async {
    final viewModel = context.read<EditScreenViewModel>();
    if (viewModel.questionController.text == "" || viewModel.answerController.text == "") {
      Fluttertoast.showToast(
        msg: "問題と答えの両方が入力された状態にしてください",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text("${word!.strQuestion}の変更"),
        content: Text("変更しますか？"),
        actions: [
          TextButton(
            child: Text("はい"),
            onPressed: () async {
              await viewModel.changeInsertWord();
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => WordListScreen(),
                ),
              );
            },
          ),
          TextButton(
            child: Text("いいえ"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
