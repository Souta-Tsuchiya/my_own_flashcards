import 'package:flutter/material.dart';
import 'package:my_own_flashcards/view_model/home_screen_view_model.dart';
import 'package:provider/provider.dart';

class RadioButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeScreenViewModel>();
    return Padding(
      padding: const EdgeInsets.only(left: 35.0),
      child: Column(
        children: [
          RadioListTile(
            title: Text("暗記済みの単語を除外する", style: TextStyle(fontSize: 18.0),),
            value: false,
            groupValue: viewModel.radioButtonGroupValue,
            onChanged: (bool? value) => _changeRadioButtonGroupValue(context, value!),
          ),
          RadioListTile(
            title: Text("暗記済みの単語を含む", style: TextStyle(fontSize: 18.0)),
            value: true,
            groupValue: viewModel.radioButtonGroupValue,
            onChanged: (bool? value) => _changeRadioButtonGroupValue(context, value!),
          ),
        ],
      ),
    );
  }

  _changeRadioButtonGroupValue(BuildContext context, bool value) {
    final viewModel = context.read<HomeScreenViewModel>();
    viewModel.changeRadioButtonGroupValue(value);
  }
}
