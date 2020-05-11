import 'package:flutter/foundation.dart';

class WorkData extends ChangeNotifier {
  bool _workState = false;
  String _testData;
  int _count = 0;

  int get count {
    return _count;
  }

  bool get workState {
    return _workState;
  }

  String get testData {
    return _testData;
  }

  void updateWorkState() {
    _workState = !_workState;
    _count += 1;
    notifyListeners();
  }

  void updateTestData(String newTestData) {
    _testData = newTestData;
    notifyListeners();
  }

}