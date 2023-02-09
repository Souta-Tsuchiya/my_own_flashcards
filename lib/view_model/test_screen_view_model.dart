import 'package:flutter/material.dart';
import 'package:my_own_flashcards/model/db/data_base_manager.dart';
import 'package:my_own_flashcards/util/constant.dart';

class TestScreenViewModel extends ChangeNotifier {
  final DataBaseManager dataBaseManager;

  TestScreenViewModel({required this.dataBaseManager});

  int numberOfQuestion = 0;
  int testIndex = 0;
  String txtQuestion = "りんご";
  String txtAnswer = "apple";
  bool isMemorized = false;

  List<Word> testData = [];

  TestStatus testStatus = TestStatus.BEFORE_START;

  bool isQuestionCardPart = false;
  bool isAnswerCardPart = false;
  bool isMemorizeCheckPart = false;
  bool isFaButtonPart = false;
  bool isEndMessage = false;

  void changeIsMemorized(bool value) {
    isMemorized = value;
    notifyListeners();
  }

  void initTestScreen(bool memorizedWordContain) async {
    if (memorizedWordContain) {
      testData = await dataBaseManager.allWords;
    } else {
      testData = await dataBaseManager.unMemorizeWords;
    }
    testData.shuffle();
    numberOfQuestion = testData.length;
    testIndex = 0;
    testStatus = TestStatus.BEFORE_START;

    isQuestionCardPart = false;
    isAnswerCardPart = false;
    isMemorizeCheckPart = false;
    isFaButtonPart = true;
    isEndMessage = false;

    notifyListeners();
  }

  Future<void> changeTestStatus() async{
    switch (testStatus) {
      case TestStatus.BEFORE_START:
        testStatus = TestStatus.SHOW_QUESTION;
        showQuestion();
        break;
      case TestStatus.SHOW_QUESTION:
        testStatus = TestStatus.SHOW_ANSWER;
        showAnswer();
        break;
      case TestStatus.SHOW_ANSWER:
        await _updateMemorizeFlag();

        if (numberOfQuestion == 0) {
          testStatus = TestStatus.FINISHED;
          isFaButtonPart = false;
          isEndMessage = true;
          notifyListeners();
        } else {
          testStatus = TestStatus.SHOW_QUESTION;
          reShowQuestion();
        }
        break;
      case TestStatus.FINISHED:
        break;
    }
  }

  void showQuestion() {
    isQuestionCardPart = true;
    txtQuestion = testData[testIndex].strQuestion;
    numberOfQuestion -= 1;

    notifyListeners();
  }

  void reShowQuestion() {
    isAnswerCardPart = false;
    isMemorizeCheckPart = false;
    testIndex += 1;
    txtQuestion = testData[testIndex].strQuestion;
    numberOfQuestion -= 1;

    notifyListeners();
  }

  void reStartQuestion() {
    numberOfQuestion = testData.length - 1;
    testIndex = 0;
    testStatus = TestStatus.SHOW_QUESTION;
    txtQuestion = testData[testIndex].strQuestion;

    isQuestionCardPart = true;
    isAnswerCardPart = false;
    isMemorizeCheckPart = false;
    isFaButtonPart = true;
    isEndMessage = false;

    notifyListeners();
  }

  void showAnswer() {
    isAnswerCardPart = true;
    isMemorizeCheckPart = true;
    txtAnswer = testData[testIndex].strAnswer;
    isMemorized = testData[testIndex].isMemorized;

    notifyListeners();
  }

  Future<void> _updateMemorizeFlag() async {
    await dataBaseManager.updateWord(
      Word(
        strQuestion: testData[testIndex].strQuestion,
        strAnswer: testData[testIndex].strAnswer,
        isMemorized: isMemorized,
      ),
    );
  }
}
