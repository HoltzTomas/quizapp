import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quiz_app/models/Question.dart';

//We use get package for our state managment

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  //Lets animate our progress bar

  AnimationController _animationController;
  Animation _animation;
  //so that we can access our animation outside
  Animation get animation => this._animation;

  PageController _pageController;
  PageController get pageController => this._pageController;

  List<Question> _questions = simpleData
      .map((question) => Question(
          id: question['id'],
          question: question['question'],
          options: question['options'],
          answer: question['answer_index']))
      .toList();

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  int _correctAns;
  int get correctAns => this._correctAns;

  int _selectedAns;
  int get selectedAns => this._selectedAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  List<Question> get questions => this._questions;

  @override
  void onInit() {
    //Our animation duration is 60s
    //so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        //update like setState
        update();
      });

    //Start our animation
    //Once 60s is completed go to the next question
    _animationController.forward().whenComplete(nextQuestion);

    _pageController = PageController();

    super.onInit();
  }

  //Called just before controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    //because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    //It will stop the counter
    _animationController.stop();
    update();

    //Once user select an ans after 3sec it will go the next qn
    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 50), curve: Curves.ease);

      //Reset the counter
      _animationController.reset();

      _animationController.forward().whenComplete(nextQuestion);
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
