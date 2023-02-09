import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("セルフ単語帳", style: TextStyle(fontSize: 40.0),),
        Text("My Own FlashCard", style: TextStyle(fontSize: 24.0),),
      ],
    );
  }
}
