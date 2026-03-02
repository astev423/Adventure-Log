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
  Map<String, dynamic> toJson() => {
    'locationName': locationName,
    'locationCoordinates': locationCoordinates,
    'locationRating': locationRating,
    'reasonForRating': reasonForRating,
  };
}
