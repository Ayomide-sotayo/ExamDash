import 'package:flutter/material.dart';

class ResultProvider extends ChangeNotifier {
  int? score;
  String? readinessBand;
  List<String> weakAreas = [];
  String? nextBestAction;

  void setResult({
    required int score,
    required String band,
    required List<String> weakAreas,
    required String nextBestAction,
  }) {
    this.score = score;
    this.readinessBand = band;
    this.weakAreas = weakAreas;
    this.nextBestAction = nextBestAction;
    notifyListeners();
  }
}

class MissionProvider extends ChangeNotifier {
  String? missionId;
  String? missionTitle;
  bool isActivated = false;

  void startMission(String id, String title) {
    missionId = id;
    missionTitle = title;
    notifyListeners();
  }

  void markActivated() {
    isActivated = true;
    notifyListeners();
  }
}
