class User {
  final String username;
  final String email;
  final String? profilePictureURL;

  User(this.username, this.email, {this.profilePictureURL});

  /// Example req: final response = await http.post(url, headers, body: jsonEncode(model.toJson()));
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "profilePictureURL": profilePictureURL,
    };
  }

  static User fromJSON(Map<String, dynamic> json) {
    return User(
      json["displayName"] as String,
      json["email"] as String,
      profilePictureURL: json["profilePictureURL"] as String?,
    );
  }
}
