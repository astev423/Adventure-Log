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

  if (querySnapshot.docs.isEmpty) {
    return [];
  }

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
