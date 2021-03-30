import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoriesProvider extends ChangeNotifier {
  Stream<QuerySnapshot> getCategories(String category)  {
    return FirebaseFirestore.instance
        .collection("courses")
        .where('category', isEqualTo: category)
        .snapshots();
  }
}
