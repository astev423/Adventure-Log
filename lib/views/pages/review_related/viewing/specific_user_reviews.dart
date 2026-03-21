import "package:adventure_log/controllers/utils/constants.dart" as constants;
import "package:adventure_log/data/review_queries.dart";
import "package:adventure_log/views/widgets/filtered_reviews_page_layout.dart";
import "package:adventure_log/views/widgets/reviews_list.dart";
import "package:flutter/material.dart";

class SpecificUserReviews extends StatelessWidget {
  final String usernameToSeePostsFrom;

  const SpecificUserReviews(this.usernameToSeePostsFrom, {super.key});

  @override
  Widget build(BuildContext context) {
    var header = Align(
      alignment: .topCenter,
      child: constants.headerText(
        "Reviews by: $usernameToSeePostsFrom",
        context,
      ),
    );
    var reviewsList = ReviewsList(
      fetchAllReviewsFromUser(usernameToSeePostsFrom),
    );

    return FilteredReviewsPageLayout(header, reviewsList);
  }
}
