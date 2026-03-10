class Review {
  final String locationName;
  final String locationCoordinates;
  final int locationRating;
  final String reasonForRating;

  Review(
    this.locationName,
    this.locationCoordinates,
    this.locationRating,
    this.reasonForRating,
  );

  /// Example req: final response = await http.post(url, headers, body: jsonEncode(model.toJson()));
  Map<String, dynamic> toJson() {
    return {
      'locationName': locationName,
      'locationCoordinates': locationCoordinates,
      'locationRating': locationRating,
      'reasonForRating': reasonForRating,
    };
  }

  static Review fromJSON(Map<String, dynamic> json) {
    final locationName = json['locationName'];
    final locationCoordinates = json['locationCoordinates'];
    final locationRating = json['locationRating'];
    final reasonForRating = json['reasonForRating'];

    return Review(
      locationName,
      locationCoordinates,
      locationRating,
      reasonForRating,
    );
  }
}
