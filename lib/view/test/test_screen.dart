import 'package:flutter/material.dart';
import 'package:my_own_flashcards/view_model/test_screen_view_model.dart';
import 'package:provider/provider.dart';

import 'components/memorize_check_part.dart';

class TestScreen extends StatelessWidget {
  final bool memorizedWordContain;

  TestScreen({required this.memorizedWordContain});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TestScreenViewModel>();
    Future(() {
      viewModel.initTestScreen(memorizedWordContain);
    });

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () => _finishMessage(context),
        ),
        title: Text("かくにんテスト"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 24.0,
              ),
              Selector<TestScreenViewModel, int>(
                selector: (context, viewModel) => viewModel.numberOfQuestion,
                builder: (context, numberOfQuestion, child) {
                  return _numOfQuestionPart(context);
                },
              ),
              const SizedBox(
                height: 64.0,
              ),
              Selector<TestScreenViewModel, bool>(
                selector: (context, viewModel) => viewModel.isQuestionCardPart,
                builder: (context, isQuestionCardPart, child) {
                  if (isQuestionCardPart) {
                    return _questionCardPart(context);
                  } else {
                    return Container();
                  }
                },
              ),
              Selector<TestScreenViewModel, bool>(
                selector: (context, viewModel) => viewModel.isAnswerCardPart,
                builder: (context, isAnswerCardPart, child) {
                  if (isAnswerCardPart) {
                    return _answerCardPart(context);
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              Selector<TestScreenViewModel, bool>(
                selector: (context, viewModel) => viewModel.isMemorizeCheckPart,
                builder: (context, isMemorizeCheckPart, child) {
                  if (isMemorizeCheckPart) {
                    return MemorizeCheckPart();
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
          Selector<TestScreenViewModel, bool>(
            selector: (context, viewModel) => viewModel.isEndMessage,
            builder: (context, isEndMessage, child) {
              if (isEndMessage) {
                return _endMessage(context);
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      floatingActionButton: Selector<TestScreenViewModel, bool>(
        selector: (context, viewModel) => viewModel.isFaButtonPart,
        builder: (context, isFaButtonPart, child) {
          if (isFaButtonPart && viewModel.testData.length >= 1) {
            return FloatingActionButton(
              child: Icon(Icons.skip_next),
              tooltip: "次にすすむ",
              onPressed: () => _changeTestStatus(context),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _numOfQuestionPart(BuildContext context) {
    final viewModel = context.read<TestScreenViewModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "のこり問題数:",
          style: TextStyle(fontSize: 18.0),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          viewModel.numberOfQuestion.toString(),
          style: TextStyle(fontSize: 32.0),
        ),
      ],
    );
  }

  Widget _questionCardPart(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("assets/images/image_flash_question.png"),
        Selector<TestScreenViewModel, String>(
          selector: (context, viewModel) => viewModel.txtQuestion,
          builder: (context, txtQuestion, child) {
            return Text(
              txtQuestion,
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            );
          },
        ),
      ],
    );
  }

  Widget _answerCardPart(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("assets/images/image_flash_answer.png"),
        Selector<TestScreenViewModel, String>(
          selector: (context, viewModel) => viewModel.txtAnswer,
          builder: (context, txtAnswer, child) {
            return Text(
              txtAnswer,
              style: TextStyle(fontSize: 24.0),
            );
          },
        ),
      ],
    );
  }

  Widget _endMessage(BuildContext context) {
    return Center(
        child: Text(
      "テスト終了",
      style: TextStyle(fontSize: 60.0, color: Colors.white),
    ));
  }

  _changeTestStatus(BuildContext context) async {
    final viewModel = context.read<TestScreenViewModel>();
    await viewModel.changeTestStatus();
  }

  _finishMessage(BuildContext context) {
    final viewModel = context.read<TestScreenViewModel>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text("テストの終了"),
        content: Text("テストを終了しますか？"),
        actions: [
          TextButton(
            child: Text("はい", style: TextStyle(color: Colors.white),),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text("いいえ", style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.blue),
            child: Text("もう一回"),
            onPressed: (viewModel.numberOfQuestion == 0 && viewModel.testData.length >= 1)
                ? () {
                    Navigator.pop(context);
                    viewModel.reStartQuestion();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
