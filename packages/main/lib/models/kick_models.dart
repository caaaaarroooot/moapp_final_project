import 'package:flutter_bloc/flutter_bloc.dart';

// kick_models.dart
enum KickState { neutral, init, complete }

class KickCounter extends Cubit<KickState> {
  KickCounter() : super(KickState.neutral);
  int count = 0;

  void setKickState(KickState newState) {
    emit(newState);
  }

  void increment() {
    count++;
    print("count: $count");
    emit(state);
  }

  void reset() {
    count = 0;
    emit(state);
  }
}
