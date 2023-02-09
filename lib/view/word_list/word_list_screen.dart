import 'package:flutter/material.dart';
import 'package:my_own_flashcards/model/db/data_base_manager.dart';
import 'package:my_own_flashcards/util/constant.dart';
import 'package:my_own_flashcards/view/edit/edit_screen.dart';
import 'package:my_own_flashcards/view_model/word_list_screen_view_model.dart';
import 'package:provider/provider.dart';

class WordListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<WordListScreenViewModel>();
    Future(() => {
          viewModel.getAllWords(),
        });

    return Scaffold(
      appBar: AppBar(
        title: Text("単語一覧"),
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            tooltip: "暗記済み単語を下に",
            onPressed: (viewModel.allWords.length == 0) ? null : () => _sortWords(context),
          ),
        ],
      ),
      body: Selector<WordListScreenViewModel, List<Word>>(
        selector: (context, viewModel) => viewModel.allWords,
        builder: (context, allWords, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: viewModel.allWords.length,
              itemBuilder: (context, int index) => _wordItem(context, index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "新しい単語の登録",
        onPressed: () => _openEditScreen(context, EditScreenType.ADD, null),
      ),
    );
  }

  Widget _wordItem(BuildContext context, int index) {
    final viewModel = context.read<WordListScreenViewModel>();

    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      color: Colors.indigo,
      child: ListTile(
        title: Text(
          viewModel.allWords[index].strQuestion,
          style: TextStyle(fontSize: 20.0),
        ),
        subtitle: Text(
          viewModel.allWords[index].strAnswer,
          style: TextStyle(fontFamily: "Mont", fontSize: 18.0),
        ),
        trailing: viewModel.allWords[index].isMemorized ? Icon(Icons.check_circle) : null,
        onLongPress: () => _deleteWord(context, index),
        onTap: () => _openEditScreen(context, EditScreenType.Edit, viewModel.allWords[index]),
      ),
    );
  }

  _openEditScreen(BuildContext context, EditScreenType editScreenType, Word? word) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(editScreenType: editScreenType, word: word),
      ),
    );
  }

  _deleteWord(BuildContext context, int index) {
    final viewModel = context.read<WordListScreenViewModel>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(viewModel.allWords[index].strQuestion),
        content: Text("この単語を削除しますか?"),
        actions: [
          TextButton(
            child: Text("はい",style: TextStyle(color: Colors.white),),
            onPressed: () {
              viewModel.deleteWord(index);
              Navigator.pop(context);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.white),
            child: Text("いいえ"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  _sortWords(BuildContext context) {
    final viewModel = context.read<WordListScreenViewModel>();
    if (viewModel.isSort) {
      viewModel.getAllWords();
    } else {
      viewModel.getSortWords();
    }
  }
}
