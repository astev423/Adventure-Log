import "package:adventure_log/controllers/utils/constants.dart" as constants;
import "package:adventure_log/controllers/utils/responsiveness.dart";
import "package:adventure_log/data/firestore_queries.dart";
import "package:adventure_log/views/widgets/reviews_list.dart";
import "package:flutter/material.dart";

class ViewSpecificUserReviews extends StatelessWidget {
  final String usernameToSeePostsFrom;

  const ViewSpecificUserReviews(this.usernameToSeePostsFrom, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.teal,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            spacing: 20,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: .topLeft,
                    child: constants.appThemedButton(
                      () => Navigator.pop(context),
                      "Click here to go back!",
                    ),
                  ),
                  Align(
                    alignment: .topCenter,
                    child: constants.headerText(
                      "Reviews by: $usernameToSeePostsFrom",
                      context,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: responsiveHeight(context, 600),
                width: responsiveWidth(context, 800),
                child: ReviewsList(
                  fetchAllReviewsFromUser(usernameToSeePostsFrom),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
