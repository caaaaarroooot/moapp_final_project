import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

Future<void> saveGoalAndProgress(int goal, int progress) async {
  print("Hello");
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      await userDoc.collection('goals').doc(today).set({
        'goal': goal,
        'progress': progress,
      });

      print('Goal and progress saved successfully!');
    } else {
      print('User is not signed in.');
    }
  } catch (error) {
    print('Error saving goal and progress: $error');
  }
}
