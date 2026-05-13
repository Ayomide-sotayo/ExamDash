import 'package:flutter/material.dart';

class DiagnosticProvider extends ChangeNotifier {
  String? sessionId;
  List<Map<String, dynamic>> questions = [];
  int currentQuestionIndex = 0;
  Map<String, String> answers = {};

  void startSession(String id, List<Map<String, dynamic>> qs) {
    sessionId = id;
    questions = qs;
    currentQuestionIndex = 0;
    answers = {};
    notifyListeners();
  }

  void submitAnswer(String questionId, String answer) {
    answers[questionId] = answer;
    currentQuestionIndex++;
    notifyListeners();
  }

  bool get isComplete => currentQuestionIndex >= questions.length;
}
