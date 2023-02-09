import 'package:flutter/material.dart';
import 'package:my_own_flashcards/view/test/test_screen.dart';
import 'package:my_own_flashcards/view/word_list/word_list_screen.dart';
import 'package:my_own_flashcards/view_model/home_screen_view_model.dart';
import 'package:provider/provider.dart';
import '../common_parts/button_with_icon.dart';
import 'components/radio_buttons.dart';
import 'components/title_text.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Image.asset("assets/images/image_title.png")),
            TitleText(),
            Divider(
              indent: 12.0,
              endIndent: 12.0,
              color: Colors.white,
              height: 32.0,
              thickness: 1.0,
            ),
            ButtonWithIcon(
              icon: Icon(Icons.play_arrow),
              label: "かくにんテストをする",
              onPressed: () => _openTestScreen(context),
              color: Colors.brown,
            ),
            SizedBox(
              height: 8.0,
            ),
            Selector<HomeScreenViewModel, bool>(
              selector: (context, viewModel) => viewModel.radioButtonGroupValue,
              builder: (context, radioButtonGroupValue, child) {
                return RadioButtons();
              },
            ),
            SizedBox(
              height: 32.0,
            ),
            ButtonWithIcon(
              icon: Icon(Icons.list),
              label: "単語一覧を見る",
              onPressed: () => _openWordListScreen(context),
              color: Colors.grey,
            ),
            SizedBox(
              height: 150.0,
            ),
            Text(
              "powered by Black Bears",
              style: TextStyle(fontFamily: "Mont"),
            )
          ],
        ),
      ),
    );
  }

  _openTestScreen(BuildContext context) {
    final viewModel = context.read<HomeScreenViewModel>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TestScreen(
          memorizedWordContain: viewModel.radioButtonGroupValue,
        ),
      ),
    );
  }

  _openWordListScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WordListScreen(),
      ),
    );
  }
}
