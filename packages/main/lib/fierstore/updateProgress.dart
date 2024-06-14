import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

Future<void> updateProgress(int newProgress) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      await userDoc.collection('goals').doc(today).update({
        'progress': newProgress,
      });

      print('Progress updated successfully!');
    } else {
      print('User is not signed in.');
    }
  } catch (error) {
    print('Error updating progress: $error');
  }
}
