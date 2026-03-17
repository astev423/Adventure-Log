class ReviewInfo {
  final String posterUsername;
  final String locationName;
  final String locationCoordinates;
  final int locationRating;
  final String? imageURL;
  final String? reasonForRating;

  ReviewInfo(
    this.posterUsername,
    this.locationName,
    this.locationCoordinates,
    this.locationRating, {
    this.imageURL,
    this.reasonForRating,
  });

  /// Example req: final response = await http.post(url, headers, body: jsonEncode(model.toJson()));
  Map<String, dynamic> toJson() {
    return {
      'posterUsername': posterUsername,
      'locationName': locationName,
      'locationCoordinates': locationCoordinates,
      'imageURL': imageURL,
      'locationRating': locationRating,
      'reasonForRating': reasonForRating,
    };
  }

  static ReviewInfo fromJSON(Map<String, dynamic> json) {
    final posterUsername = json['posterUsername'];
    final locationName = json['locationName'];
    final locationCoordinates = json['locationCoordinates'];
    final locationRating = json['locationRating'];
    final reasonForRating = json['reasonForRating'];
    final imageURL = json['imageURL'];

    return ReviewInfo(
      posterUsername,
      locationName,
      locationCoordinates,
      locationRating,
      reasonForRating: reasonForRating,
      imageURL: imageURL,
    );
  }
}
