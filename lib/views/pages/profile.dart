import "package:adventure_log/controllers/auth/utils.dart";
import "package:adventure_log/data/cloud_storage_funcs.dart";
import "package:adventure_log/data/review_queries.dart";
import "package:adventure_log/data/user_queries.dart";
import "package:adventure_log/views/component_widgets/upload_image.dart";
import "package:file_picker/file_picker.dart";
import "../../controllers/utils/constants.dart";
import "../../controllers/utils/responsiveness.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width < 850) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              headerText("Account information", context),
              _ProfileDetails(),
              const _ReviewStats(),
            ],
          ),
        ),
      );
    }

    return Center(
      child: Column(
        spacing: 20,
        children: [
          headerText("Account information", context),
          Padding(
            padding: EdgeInsets.only(
              left: responsiveWidth(context, 80),
              right: responsiveWidth(context, 80),
            ),
            child: Stack(
              children: [
                Align(alignment: .center, child: _ProfileDetails()),
                const Align(alignment: .centerRight, child: _ReviewStats()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  final _userAuthInfo = getCurUserAuth();

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  _ProfileDetails();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsiveHeight(context, 470),
      width: responsiveWidth(context, 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: mint,
      ),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: .min,
          spacing: 25,
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
            appThemedButton(context, _signOut, "Click here to sign out"),
          ],
        ),
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
      spacing: 10,
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
          style: ElevatedButton.styleFrom(
            backgroundColor: mint,
            side: const BorderSide(color: darkGreen, width: 2),
          ),
          child: Text(
            "Submit your profile picture",
            style: TextStyle(
              color: darkGreen,
              fontSize: responsiveFontSize(context, 10),
            ),
          ),
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

class _ReviewStats extends StatefulWidget {
  const _ReviewStats();

  @override
  State<_ReviewStats> createState() => _ReviewStatsState();
}

class _ReviewStatsState extends State<_ReviewStats> {
  int? _totalReviewsPosted;
  int? _totalReviewsSaved;
  int? _totalReviewsIgnored;

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsiveHeight(context, 470),
      width: responsiveWidth(context, 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: mint,
      ),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: .min,
          spacing: 25,
          children: [
            Text(
              "Profile stats:",
              style: TextStyle(fontSize: responsiveFontSize(context, 20)),
            ),
            Text("Total reviews posted: ${_totalReviewsPosted ?? ""}"),
            Text("Total reviews ignored: ${_totalReviewsIgnored ?? ""}"),
            Text("Total reviews saved: ${_totalReviewsSaved ?? ""}"),
          ],
        ),
      ),
    );
  }

  void _fetchStats() async {
    final user = getCurUserAuth();
    _totalReviewsPosted = (await fetchAllReviewsFromUser(
      (await getCurUserData()).username,
    )).length;
    _totalReviewsIgnored = (await fetchAllReviewsUserIgnored(user.uid)).length;
    _totalReviewsSaved = (await fetchAllReviewsUserSaved(user.uid)).length;

    setState(() {
      _totalReviewsPosted = _totalReviewsPosted;
      _totalReviewsIgnored = _totalReviewsIgnored;
      _totalReviewsSaved = _totalReviewsSaved;
    });
  }
}
