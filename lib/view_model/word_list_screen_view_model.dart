import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_own_flashcards/model/db/data_base_manager.dart';

class WordListScreenViewModel extends ChangeNotifier {
  final DataBaseManager dataBaseManager;

  WordListScreenViewModel({required this.dataBaseManager});

  List<Word> allWords = [];
  bool isSort = false;

  getAllWords() async{
    allWords = await dataBaseManager.allWords;
    isSort = false;
    notifyListeners();
  }

  void deleteWord(int index) async{
    await dataBaseManager.deleteWord(allWords[index]);
    Fluttertoast.showToast(
      msg: "削除が完了しました",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
    getAllWords();
  }

  void getSortWords() async{
    allWords = await dataBaseManager.sortAllWords;
    isSort = true;
    notifyListeners();
  }
}