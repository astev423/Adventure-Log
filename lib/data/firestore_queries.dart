import 'package:adventure_log/data/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>?> fetchAllReviews() async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection("secretMessages")
      .get();

  if (querySnapshot.docs.isEmpty) {
    return null;
  }

  return querySnapshot.docs.map((doc) => doc.data()).toList();
}

void addReview(Review review) async {
  FirebaseFirestore.instance.collection("reviews").add(review.toJson());
}
