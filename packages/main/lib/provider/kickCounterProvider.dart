import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../fierstore/saveGoalAndProgress.dart';
import '../fierstore/upateGoal.dart';
import '../fierstore/updateProgress.dart';

class KickCounterProvider with ChangeNotifier {
  int _count = 0;
  int _goal = 0;

  int get count => _count;
  int get goal => _goal;

  void increment() {
    _count++;
    saveGoalAndProgress(_goal, _count);
    notifyListeners();
  }

  void setGoal(int newGoal) {
    _goal = newGoal;
    updateGoal(newGoal); // 새로운 updateGoal 함수 호출
    notifyListeners();
  }

  void setProgress1(int newProgress) {
    print(_count);
    _count = newProgress;
    print(_count);
    updateProgress(_count); // 새로운 updateProgress 함수 호출

    notifyListeners();
  }

  void setProgress2(int newProgress) {
    print(_count);
    _count += newProgress;
    print(_count);
    updateProgress(_count); // 새로운 updateProgress 함수 호출

    notifyListeners();
  }

  void reset() {
    _count = 0;
  }
}
