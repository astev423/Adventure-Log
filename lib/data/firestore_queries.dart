import 'package:adventure_log/data/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void addReview(ReviewInfo review) async {
  FirebaseFirestore.instance.collection("reviews").add(review.toJson());
}

Future<List<ReviewInfo>> fetchAllReviews() async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection("reviews")
      .get();

  if (querySnapshot.docs.isEmpty) {
    return [];
  }

  return querySnapshot.docs
      .map((doc) => ReviewInfo.fromJSON(doc.data()))
      .toList();
}
