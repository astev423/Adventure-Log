import "package:cloud_firestore/cloud_firestore.dart";

class ReviewInfo {
  final String posterUsername;
  final String locationName;
  final String locationCoordinates;
  final int locationRating;
  Timestamp timePosted;
  final String? imageURL;
  final String? reasonForRating;
  // Why not put this in user? Because joins are not as good in NoSQL so denormalization is prefered
  final String? profilePictureURL;

  ReviewInfo(
    this.posterUsername,
    this.locationName,
    this.locationCoordinates,
    this.locationRating,
    this.timePosted, {
    this.imageURL,
    this.reasonForRating,
    this.profilePictureURL,
  });

  /// Example req: final response = await http.post(url, headers, body: jsonEncode(model.toJson()));
  Map<String, dynamic> toJson() {
    return {
      "posterUsername": posterUsername,
      "locationName": locationName,
      "locationCoordinates": locationCoordinates,
      "imageURL": imageURL,
      "locationRating": locationRating,
      "reasonForRating": reasonForRating,
      "timePosted": timePosted,
      "profilePictureURL": profilePictureURL,
    };
  }

  static ReviewInfo fromJSON(Map<String, dynamic> json) {
    return ReviewInfo(
      json["posterUsername"] as String,
      json["locationName"] as String,
      json["locationCoordinates"] as String,
      (json["locationRating"] as num).toInt(),
      json["timePosted"] as Timestamp,
      imageURL: json["imageURL"] as String?,
      reasonForRating: json["reasonForRating"] as String?,
      profilePictureURL: json["profilePictureURL"] as String?,
    );
  }
}
