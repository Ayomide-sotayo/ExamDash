import 'package:flutter/material.dart';

class ExamContextProvider extends ChangeNotifier {
  String? selectedExam;

  void setExam(String exam) {
    selectedExam = exam;
    notifyListeners();
  }
}
