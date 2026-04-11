import "package:cloud_firestore/cloud_firestore.dart";

class ReviewInfo {
  final String? id;
  final String posterUsername;
  final String locationName;
  final String locationCoordinates;
  final int locationRating;
  final bool isPublic;
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
    this.isPublic,
    this.timePosted, {
    this.imageURL,
    this.reasonForRating,
    this.profilePictureURL,
    this.id,
  });

  /// Example req: final response = await http.post(url, headers, body: jsonEncode(model.toJson()));
  Map<String, dynamic> toJson() {
    return {
      "posterUsername": posterUsername,
      "locationName": locationName,
      "locationCoordinates": locationCoordinates,
      "locationRating": locationRating,
      "isPublic": isPublic,
      "timePosted": timePosted,
      "imageURL": imageURL,
      "reasonForRating": reasonForRating,
      "profilePictureURL": profilePictureURL,
    };
  }

  static ReviewInfo fromJSON(Map<String, dynamic> json, String id) {
    return ReviewInfo(
      json["posterUsername"] as String,
      json["locationName"] as String,
      json["locationCoordinates"] as String,
      (json["locationRating"] as num).toInt(),
      json["isPublic"] as bool,
      json["timePosted"] as Timestamp,
      imageURL: json["imageURL"] as String?,
      reasonForRating: json["reasonForRating"] as String?,
      profilePictureURL: json["profilePictureURL"] as String?,
      id: id,
    );
  }
}
