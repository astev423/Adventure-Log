import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:adventure_log/controllers/utils/responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AccountInfo());
  }
}

class AccountInfo extends StatelessWidget {
  final accountInfo = FirebaseAuth.instance.currentUser!;

  AccountInfo({super.key});
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 20,
        children: [
          headerText("Account information", context),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: .min,
              spacing: 40,
              children: [
                Text(
                  "Username: ${accountInfo.displayName}",
                  style: TextStyle(fontSize: responsiveFontSize(context, 30)),
                ),
                Text(
                  "Email: ${accountInfo.email}",
                  style: TextStyle(fontSize: responsiveFontSize(context, 30)),
                ),
                ElevatedButton(
                  onPressed: _signOut,
                  child: Text("Click here to sign out"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
