import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  Stream<QuerySnapshot> getPosts() {
    return FirebaseFirestore.instance
        .collection('courses')
        .orderBy('rating', descending: true)
        .limit(5)
        .snapshots();
  }
}
