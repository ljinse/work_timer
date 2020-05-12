import 'package:flutter/foundation.dart';

class WorkData extends ChangeNotifier {
  bool _workState = false;
  int _count = 0;

  int get count {
    return _count;
  }

  bool get workState {
    return _workState;
  }

  void updateWorkState() {
    _workState = !_workState;
    _count += 1;
    notifyListeners();
  }
}