import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_controller.dart';

import '../../constants.dart';

class Option extends StatelessWidget {
  const Option({
    Key key,
    this.text,
    this.index,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qncontroller) {
          Color getTheRightColor() {
            if (qncontroller.isAnswered) {
              if (index == qncontroller.correctAns) {
                return kGreenColor;
              } else if (index == qncontroller.selectedAns &&
                  qncontroller.selectedAns != qncontroller.correctAns) {
                return kRedColor;
              }
            }
            return kGrayColor;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
          }

          return InkWell(
            onTap: onPressed,
            child: Container(
              margin: EdgeInsets.only(top: kDefaultPadding),
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                  border: Border.all(color: getTheRightColor()),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${index + 1}.$text",
                      style:
                          TextStyle(color: getTheRightColor(), fontSize: 16)),
                  Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                          color: getTheRightColor() == kGrayColor
                              ? Colors.transparent
                              : getTheRightColor(),
                          border: Border.all(color: getTheRightColor()),
                          borderRadius: BorderRadius.circular(50)),
                      child: getTheRightColor() == kGrayColor
                          ? null
                          : Icon(getTheRightIcon(), size: 16)),
                ],
              ),
            ),
          );
        });
  }
}
