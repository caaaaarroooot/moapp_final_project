// import 'dart:io';
// import 'dart:math' as math;

// import 'package:flutter/services.dart';
// import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// import '../models/push_up_models.dart';

// Future<String> getAssetPath(String asset) async {
//   final path = await getLocalPath(asset);
//   await Directory(dirname(path)).create(recursive: true);
//   final file = File(path);
//   if (!await file.exists()) {
//     final byteData = await rootBundle.load(asset);
//     await file.writeAsBytes(byteData.buffer
//         .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//   }
//   return file.path;
// }

// Future<String> getLocalPath(String path) async {
//   return '${(await getApplicationSupportDirectory()).path}/$path';
// }

// double getAngle(PoseLandmark firstLandmark, PoseLandmark midLandmark,
//     PoseLandmark lastLandmark) {
//   double angle = math.atan2(
//           lastLandmark.y - midLandmark.y, lastLandmark.x - midLandmark.x) -
//       math.atan2(
//           firstLandmark.y - midLandmark.y, firstLandmark.x - midLandmark.x);
//   angle = angle * (180 / math.pi); // Convert radian to degree
//   angle = angle.abs(); // Angle should never be negative
//   if (angle > 180) {
//     angle = 360.0 - angle; // Always get the acute representation of the angle
//   }
//   return angle;
// }

// PushUpState? isPushUp(double angleElbow, PushUpState current) {
//   final umbralElbow = 60.0;
//   final umbralElbowExt = 160.0;

//   if (current == PushUpState.neutral &&
//       angleElbow > umbralElbowExt &&
//       angleElbow < 180.0) {
//     return PushUpState.init;
//   } else if (current == PushUpState.init &&
//       angleElbow < umbralElbow &&
//       angleElbow > 40.0) {
//     return PushUpState.complete;
//   }
// }

import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/kick_models.dart';

Future<String> getAssetPath(String asset) async {
  final path = await getLocalPath(asset);
  await Directory(dirname(path)).create(recursive: true);
  final file = File(path);
  if (!await file.exists()) {
    final byteData = await rootBundle.load(asset);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
  return file.path;
}

Future<String> getLocalPath(String path) async {
  return '${(await getApplicationSupportDirectory()).path}/$path';
}

double getAngle(PoseLandmark firstLandmark, PoseLandmark midLandmark,
    PoseLandmark lastLandmark) {
  double angle = math.atan2(
          lastLandmark.y - midLandmark.y, lastLandmark.x - midLandmark.x) -
      math.atan2(
          firstLandmark.y - midLandmark.y, firstLandmark.x - midLandmark.x);
  angle = angle * (180 / math.pi); // 라디안을 각도로 변환
  angle = angle.abs(); // 각도는 절대 음수가 아니어야 함
  if (angle > 180) {
    angle = 360.0 - angle; // 항상 각도의 예각 표현을 가져옴
  }
  return angle;
}

KickState? isKick(double kneeAngle, KickState current) {
  final thresholdKneeBent = 70.0; // 무릎이 구부러진 상태의 임계값 (초기 위치)
  final thresholdKneeExtended = 160.0; // 무릎이 펴진 상태의 임계값 (완료 위치)

  if (current == KickState.neutral && kneeAngle < thresholdKneeBent) {
    return KickState.init;
  } else if (current == KickState.init && kneeAngle > thresholdKneeExtended) {
    return KickState.complete;
  }
}
