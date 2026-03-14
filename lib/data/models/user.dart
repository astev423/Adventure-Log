class UserInfo {
  final String username;
  final String email;
  final String password;

  UserInfo(this.username, this.email, this.password);

  /// Example req: final response = await http.post(url, headers, body: jsonEncode(model.toJson()));
  Map<String, dynamic> toJson() {
    return {'username': username, 'email': email, 'password': password};
  }

  static UserInfo fromJSON(Map<String, dynamic> json) {
    final username = json['username'];
    final email = json['email'];
    final password = json['password'];

    return UserInfo(username, email, password);
  }
}
