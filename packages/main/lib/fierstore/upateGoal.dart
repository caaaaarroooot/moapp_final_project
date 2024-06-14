import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

Future<void> updateGoal(int newGoal) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      await userDoc.collection('goals').doc(today).update({
        'goal': newGoal,
      });

      print('Goal updated successfully!');
    } else {
      print('User is not signed in.');
    }
  } catch (error) {
    print('Error updating goal: $error');
  }
}
