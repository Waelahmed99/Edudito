import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  Stream<QuerySnapshot> getPopularCourses() {
    return FirebaseFirestore.instance
        .collection('courses')
        .orderBy('rating', descending: true)
        .limit(5)
        .snapshots();
  }

  Stream<QuerySnapshot> getRecommendations() {
    return FirebaseFirestore.instance
        .collection('courses')
        .orderBy('rating', descending: true)
        
        .limit(5)
        .snapshots();
  }
}
