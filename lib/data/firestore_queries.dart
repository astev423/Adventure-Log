import "models/review_info.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

void addReview(ReviewInfo review) async {
  FirebaseFirestore.instance.collection("reviews").add(review.toJson());
}

Future<List<ReviewInfo>> fetchAllReviews() async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection("reviews")
      .get();

  return querySnapshot.docs
      .map((doc) => ReviewInfo.fromJSON(doc.data()))
      .toList();
}

Future<List<ReviewInfo>> fetchAllReviewsFromUser(String username) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection("reviews")
      .where("posterUsername", isEqualTo: username)
      .get();

  return querySnapshot.docs
      .map((doc) => ReviewInfo.fromJSON(doc.data()))
      .toList();
}

Future<List<ReviewInfo>> fetchReviewsNewestFirst() async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection("reviews")
      .orderBy("timePosted", descending: true)
      .get();

  return querySnapshot.docs
      .map((doc) => ReviewInfo.fromJSON(doc.data()))
      .toList();
}

void addUserToFirestore(User user, String username) async {
  await user.updateDisplayName(username);

  await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
    "uid": user.uid,
    "email": user.email,
    "displayName": username,
    "createdAt": FieldValue.serverTimestamp(),
  });
}
