import "package:adventure_log/controllers/auth/utils.dart";
import "package:adventure_log/data/models/user.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart" as auth;

/// Add user via existing auth data and the username the user entered
void addUserToFirestore(String username) async {
  final user = getCurUserAuth();

  await user.updateDisplayName(username);
  await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
    "uid": user.uid,
    "email": user.email,
    "displayName": username,
    "createdAt": FieldValue.serverTimestamp(),
  });
}

Future<User> getCurUserData() async {
  final query = await fetchUserQuery(getCurUserAuth());

  return User.fromJSON(query.docs[0].data());
}

Future<QuerySnapshot<Map<String, dynamic>>> fetchUserQuery(
  auth.User user,
) async {
  return FirebaseFirestore.instance
      .collection("users")
      .where("displayName", isEqualTo: user.displayName)
      .limit(1)
      .get();
}

Future<void> updateUserProfile(
  auth.User user,
  Map<Object, Object?> newData,
) async {
  final query = await fetchUserQuery(user);

  await query.docs.first.reference.update(newData);
}
