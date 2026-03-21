import "package:adventure_log/controllers/auth/utils.dart";
import "package:adventure_log/data/cloud_storage_funcs.dart";
import "package:adventure_log/data/user_queries.dart";
import "package:adventure_log/views/widgets/upload_image.dart";
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
  final _userAuthInfo = getCurUserAuth();

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
                  "Username: ${_userAuthInfo.displayName}",
                  style: TextStyle(fontSize: responsiveFontSize(context, 20)),
                ),
                Text(
                  "Email: ${_userAuthInfo.email}",
                  style: TextStyle(fontSize: responsiveFontSize(context, 20)),
                ),
                Text(
                  "Upload a profile picture",
                  style: TextStyle(fontSize: responsiveFontSize(context, 20)),
                ),
                const _AddProfilePicture(),
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
        if (_profilePic != null)
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: responsiveWidth(context, 100),
              maxHeight: responsiveHeight(context, 100),
            ),
            child: Image(image: _profilePic!),
          ),
        UploadImage(_onFileAttached),
        ElevatedButton(
          onPressed: () async {
            if (_newProfilePicFile == null) {
              return;
            }

            final url = await uploadImageAndGetUrl(_newProfilePicFile!);
            await updateUserProfile(getCurUserAuth(), {
              "profilePictureURL": url,
            });
            _tryFetchProfilePic();
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
    final curUserData = await getCurUserData();
    if (curUserData.profilePictureURL == null) {
      return;
    }

    setState(() {
      _profilePic = NetworkImage(curUserData.profilePictureURL!);
    });
  }
}
