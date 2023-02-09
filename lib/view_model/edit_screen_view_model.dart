import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_own_flashcards/model/db/data_base_manager.dart';

class EditScreenViewModel extends ChangeNotifier {
  final DataBaseManager dataBaseManager;

  EditScreenViewModel({required this.dataBaseManager});

  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  insertQuestionControllerText(Word? word) {
    questionController.text = word!.strQuestion;
  }

  insertAnswerControllerText(Word? word) {
    answerController.text = word!.strAnswer;
  }

  void textEditingControllerClear() {
    questionController.clear();
    answerController.clear();
  }

  Future<void> insertWord() async {
    var word =
        Word(strQuestion: questionController.text, strAnswer: answerController.text, isMemorized: false);

    try {
      await dataBaseManager.addWord(word);
      Fluttertoast.showToast(
        msg: "登録が完了しました",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } on SqliteException catch (e) {
      Fluttertoast.showToast(
        msg: "この問題は既に登録されていますので登録できません",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    questionController.clear();
    answerController.clear();
  }

  Future<void> changeInsertWord() async {
    var word =
        Word(strQuestion: questionController.text, strAnswer: answerController.text, isMemorized: false);

    try {
      await dataBaseManager.updateWord(word);
      Fluttertoast.showToast(
        msg: "登録変更が完了しました",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } on SqliteException catch (e) {
      Fluttertoast.showToast(
        msg: "この問題の解答の変更に失敗しました",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    questionController.clear();
    answerController.clear();
  }
}
