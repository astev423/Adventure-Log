import "package:adventure_log/data/cloud_storage_funcs.dart";
import "package:adventure_log/views/widgets/upload_image.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:file_picker/file_picker.dart";

import "../../controllers/utils/constants.dart";
import "../../controllers/utils/responsiveness.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: mint,
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: .min,
              spacing: 40,
              children: [
                Text(
                  "Username: ${accountInfo.displayName}",
                  style: TextStyle(fontSize: responsiveFontSize(context, 20)),
                ),
                Text(
                  "Email: ${accountInfo.email}",
                  style: TextStyle(fontSize: responsiveFontSize(context, 20)),
                ),
                Text(
                  "Upload a profile picture",
                  style: TextStyle(fontSize: responsiveFontSize(context, 20)),
                ),
                appThemedButton(_signOut, "Click here to sign out"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddProfilePicture extends StatefulWidget {
  const _AddProfilePicture();

  @override
  State<_AddProfilePicture> createState() => _AddProfilePictureState();
}

class _AddProfilePictureState extends State<_AddProfilePicture> {
  PlatformFile? _newProfilePicFile;
  NetworkImage? _profilePic;

  @override
  void initState() {
    super.initState();
    _tryFetchProfilePic();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_profilePic != null) const Text("Current Profile picture:"),
        if (_profilePic != null) Image(image: _profilePic!),
        UploadImage(_onFileAttached),
        ElevatedButton(
          onPressed: () async {
            if (_newProfilePicFile == null) {
              return;
            }

            final displayName = FirebaseAuth.instance.currentUser?.displayName;
            final userQuery = await FirebaseFirestore.instance
                .collection("users")
                .where("displayName", isEqualTo: displayName)
                .limit(1)
                .get();

            final profPicURL = await uploadImageAndGetUrl(_newProfilePicFile!);
            await userQuery.docs.first.reference.update({
              "profilePictureURL": profPicURL,
            });
          },
          child: const Text("Submit your profile picture"),
        ),
      ],
    );
  }

  void _onFileAttached(PlatformFile file) {
    setState(() {
      _newProfilePicFile = file;
    });
  }

  void _tryFetchProfilePic() async {
    final displayName = FirebaseAuth.instance.currentUser?.displayName;
    final userQuery = await FirebaseFirestore.instance
        .collection("users")
        .where("displayName", isEqualTo: displayName)
        .limit(1)
        .get();

    setState(() {
      _profilePic = NetworkImage(
        userQuery.docs.first.get("profilePictureURL") as String,
      );
    });
  }
}
