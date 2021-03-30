import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class EnrollmentProvider extends ChangeNotifier {
  Future enroll(String uid, QueryDocumentSnapshot snapshot) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('enrollments')
        .doc(snapshot.id)
        .set(snapshot.data());
    notifyListeners();
  }

  Future disenroll(String uid, QueryDocumentSnapshot snapshot) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('enrollments')
        .doc(snapshot.id)
        .delete();
    notifyListeners();
  }

  Future checkIfEnrolled(String uid, QueryDocumentSnapshot snapshot) async {
    var docSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('enrollments')
        .doc(snapshot.id)
        .get();
    return docSnap.exists;
  }

  Stream<QuerySnapshot> getEnrolled(String uid) {
    var docSnap = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('enrollments')
        .snapshots();
    return docSnap;
  }
}
