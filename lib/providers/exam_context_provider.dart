import 'package:flutter/material.dart';

class ExamContextProvider extends ChangeNotifier {
  String? selectedExam;
  bool? isFirstAttempt;
  String? resitWindow;

  void setExam(String exam) {
    selectedExam = exam;
    notifyListeners();
  }

  void setAttemptStatus(bool firstAttempt) {
    isFirstAttempt = firstAttempt;
    notifyListeners();
  }

  void setResitWindow(String? window) {
    resitWindow = window;
    notifyListeners();
  }

  bool get isContextComplete => selectedExam != null && isFirstAttempt != null;
}
