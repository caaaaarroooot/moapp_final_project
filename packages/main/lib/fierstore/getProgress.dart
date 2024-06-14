import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

Future<int?> getProgress() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final docSnapshot = await userDoc.collection('goals').doc(today).get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        final data = docSnapshot.data();
        if (data != null && data.containsKey('progress')) {
          return data['progress'] as int;
        }
      }
    } else {
      print('User is not signed in.');
    }
  } catch (error) {
    print('Error getting progress: $error');
  }
  return null;
}
