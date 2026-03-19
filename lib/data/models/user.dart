class UserInfo {
  final String username;
  final String email;

  UserInfo(this.username, this.email);

  /// Example req: final response = await http.post(url, headers, body: jsonEncode(model.toJson()));
  Map<String, dynamic> toJson() {
    return {"username": username, "email": email};
  }

  static UserInfo fromJSON(Map<String, dynamic> json) {
    final username = json["displayName"] as String;
    final email = json["email"] as String;

    return UserInfo(username, email);
  }
}
