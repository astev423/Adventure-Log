import 'package:adventure_log/data/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void addReview(Review review) async {
  FirebaseFirestore.instance.collection("reviews").add(review.toJson());
}

Future<List<Review>?> fetchAllReviews() async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection("reviews")
      .get();

  if (querySnapshot.docs.isEmpty) {
    return null;
  }

  return querySnapshot.docs.map((doc) => Review.fromJSON(doc.data())).toList();
}
