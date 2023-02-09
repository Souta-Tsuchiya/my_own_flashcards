import 'package:flutter/material.dart';
import 'package:my_own_flashcards/view_model/test_screen_view_model.dart';
import 'package:provider/provider.dart';

class MemorizeCheckPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TestScreenViewModel>();

    return Selector<TestScreenViewModel, bool>(
      selector: (context, viewModel) => viewModel.isMemorized,
      builder: (context, isMemorized, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CheckboxListTile(
            title: Text("暗記済にする場合はチェックを入れて下さい。", style: TextStyle(fontSize: 12.0),),
            value: viewModel.isMemorized,
            onChanged: (bool? value) => _changeIsMemorized(context, value!),
          ),
        );
      },
    );
  }

  _changeIsMemorized(BuildContext context, bool value) {
    final viewModel = context.read<TestScreenViewModel>();
    viewModel.changeIsMemorized(value);
  }
}
