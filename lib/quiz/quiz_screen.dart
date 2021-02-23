import 'package:flutter/material.dart';
import 'package:quiz_app/quiz/components/body.dart';
import 'package:websafe_svg/websafe_svg.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [FlatButton(onPressed: () {}, child: Text("Skip"))],
      ),
      body: Body(),
    );
  }
}

