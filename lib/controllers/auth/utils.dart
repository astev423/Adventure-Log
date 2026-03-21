import "package:firebase_auth/firebase_auth.dart";

User getCurUserAuth() {
  return FirebaseAuth.instance.currentUser!;
}
