import "package:adventure_log/controllers/utils/constants.dart" as constants;
import "package:adventure_log/data/review_queries.dart";
import "package:adventure_log/views/widgets/reviews_list.dart";
import "package:flutter/material.dart";
import "package:adventure_log/views/widgets/filtered_reviews_page_layout.dart";

class NewestReviews extends StatelessWidget {
  const NewestReviews({super.key});

  @override
  Widget build(BuildContext context) {
    var header = Align(
      alignment: .topCenter,
      child: constants.headerText("Newest reviews:", context),
    );
    var reviewsList = ReviewsList(fetchReviewsNewestFirst());

    return FilteredReviewsPageLayout(header, reviewsList);
  }
}
