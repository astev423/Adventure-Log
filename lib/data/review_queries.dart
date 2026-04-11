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
  await _fetchReviewsCollection().doc(reviewId).delete();
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
