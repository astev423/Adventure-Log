import "dart:math";

import "package:adventure_log/controllers/auth/utils.dart";
import "package:adventure_log/controllers/utils/helpers.dart";
import "package:geolocator/geolocator.dart";
import "models/review_info.dart";
import "package:cloud_firestore/cloud_firestore.dart";

void addReview(ReviewInfo review) async {
  FirebaseFirestore.instance.collection("reviews").add(review.toJson());
}

Future<List<ReviewInfo>> fetchAllVisibleReviewsForCurUser() async {
  final querySnapshot = await _queryOfAllVisibleReviewsToCurUser().get();

  return _turnReviewSnapshotIntoList(querySnapshot);
}

Future<List<ReviewInfo>> fetchAllPublicReviews() async {
  final querySnapshot = await _fetchReviewsCollection()
      .where("isPublic", isEqualTo: true)
      .get();

  return _turnReviewSnapshotIntoList(querySnapshot);
}

Future<List<ReviewInfo>> fetchAllReviewsFromUser(String username) async {
  final querySnapshot = await _fetchReviewsCollection()
      .where("posterUsername", isEqualTo: username)
      .get();

  return _turnReviewSnapshotIntoList(querySnapshot);
}

Future<List<ReviewInfo>> fetchReviewsNewestFirst() async {
  final reviews = await fetchAllVisibleReviewsForCurUser();

  return sortReviewsByNewestFirst(reviews);
}

Future<List<ReviewInfo>> fetchReviewsClosestFirst(Position userCoords) async {
  final reviews = await fetchAllVisibleReviewsForCurUser();

  return sortReviewsByClosestToUser(userCoords, reviews);
}

Future<List<ReviewInfo>> fetchReviewsHighestRatedFirst() async {
  final reviews = await fetchAllVisibleReviewsForCurUser();

  return sortReviewsByHighestRatedFirst(reviews);
}

Future<void> tryDeleteReview(String reviewId) async {
  // Firestore settings performs backend validation for this so we don't need to worry about
  // users deleting posts that aren't theres
  await _fetchReviewsCollection().doc(reviewId).delete();
}

Future<ReviewInfo?> fetchRandomReview() async {
  final querySnapshot = await _queryOfAllVisibleReviewsToCurUser().get();

  if (querySnapshot.docs.isEmpty) {
    return null;
  }

  final randomDoc =
      querySnapshot.docs[Random().nextInt(querySnapshot.docs.length)];

  return ReviewInfo.fromJSON(randomDoc.data(), randomDoc.id);
}

Future<ReviewInfo?> fetchReviewById(String reviewId) async {
  final doc = await _fetchReviewsCollection().doc(reviewId).get();

  if (!doc.exists) {
    return null;
  }

  final data = doc.data();
  if (data == null) {
    return null;
  }

  return ReviewInfo.fromJSON(data, doc.id);
}

Future<void> addSavedReview(ReviewInfo review, String userId) async {
  // Instead of storing foreign keys denormalize since this is NoSQL
  await FirebaseFirestore.instance.collection("savedReviews").add({
    "userId": userId,
    "reviewId": review.id!,
    ...review.toJson(),
  });
}

Future<List<ReviewInfo>> fetchAllReviewsUserSaved(String userId) async {
  final query = await FirebaseFirestore.instance
      .collection("savedReviews")
      .where("userId", isEqualTo: userId)
      .get();

  return query.docs.map((doc) {
    return ReviewInfo.fromJSON(doc.data(), doc.data()["reviewId"] as String);
  }).toList();
}

Future<bool> isReviewSaved(String reviewId, String userId) async {
  final query = await FirebaseFirestore.instance
      .collection("savedReviews")
      .where("reviewId", isEqualTo: reviewId)
      .where("userId", isEqualTo: userId)
      .get();

  return query.docs.isNotEmpty;
}

Future<bool> tryRemovingSavedReview(String reviewId, String userId) async {
  final query = await FirebaseFirestore.instance
      .collection("savedReviews")
      .where("reviewId", isEqualTo: reviewId)
      .where("userId", isEqualTo: userId)
      .get();

  if (query.docs.isEmpty) {
    return false;
  }

  query.docs.first.reference.delete();

  return true;
}

Future<void> addIgnoredReview(ReviewInfo review, String userId) async {
  // Instead of storing foreign keys denormalize since this is NoSQL
  await FirebaseFirestore.instance.collection("ignoredReviews").add({
    "userId": userId,
    "reviewId": review.id!,
    ...review.toJson(),
  });
}

Future<bool> isReviewIgnored(String reviewId, String userId) async {
  final query = await FirebaseFirestore.instance
      .collection("ignoredReviews")
      .where("reviewId", isEqualTo: reviewId)
      .where("userId", isEqualTo: userId)
      .get();

  return query.docs.isNotEmpty;
}

CollectionReference<Map<String, dynamic>> _fetchReviewsCollection() {
  return FirebaseFirestore.instance.collection("reviews");
}

List<ReviewInfo> _turnReviewSnapshotIntoList(
  QuerySnapshot<Map<String, dynamic>> querySnapshot,
) {
  return querySnapshot.docs
      .map((doc) => ReviewInfo.fromJSON(doc.data(), doc.id))
      .toList();
}

Query<Map<String, dynamic>> _queryOfAllVisibleReviewsToCurUser() {
  return _fetchReviewsCollection().where(
    Filter.or(
      Filter("posterUsername", isEqualTo: getCurUserAuth().displayName!),
      Filter("isPublic", isEqualTo: true),
    ),
  );
}
