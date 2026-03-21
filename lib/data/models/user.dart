class UserInfo {
  final String username;
  final String email;
  final String? profilePictureURL;

  UserInfo(this.username, this.email, {this.profilePictureURL});

  /// Example req: final response = await http.post(url, headers, body: jsonEncode(model.toJson()));
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "profilePictureURL": profilePictureURL,
    };
  }

  static UserInfo fromJSON(Map<String, dynamic> json) {
    return UserInfo(
      json["displayName"] as String,
      json["email"] as String,
      profilePictureURL: json["profilePictureURL"] as String?,
    );
  }
}
