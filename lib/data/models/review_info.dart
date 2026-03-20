class ReviewInfo {
  final String posterUsername;
  final String locationName;
  final String locationCoordinates;
  final int locationRating;
  DateTime timePosted;
  final String? imageURL;
  final String? reasonForRating;

  ReviewInfo(
    this.posterUsername,
    this.locationName,
    this.locationCoordinates,
    this.locationRating,
    this.timePosted, {
    this.imageURL,
    this.reasonForRating,
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
    };
  }

  static ReviewInfo fromJSON(Map<String, dynamic> json) {
    final posterUsername = json["posterUsername"] as String;
    final locationName = json["locationName"] as String;
    final locationCoordinates = json["locationCoordinates"] as String;
    final locationRating = json["locationRating"] as int;
    final timePosted = json["timePosted"] as DateTime;
    final reasonForRating = json["reasonForRating"] as String;
    final imageURL = json["imageURL"] as String;

    return ReviewInfo(
      posterUsername,
      locationName,
      locationCoordinates,
      locationRating,
      timePosted,
      reasonForRating: reasonForRating,
      imageURL: imageURL,
    );
  }
}
