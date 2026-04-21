import "package:adventure_log/controllers/auth/utils.dart";
import "package:adventure_log/controllers/utils/constants.dart" as constants;
import "package:adventure_log/data/models/review_info.dart";
import "package:adventure_log/data/review_queries.dart";
import "package:adventure_log/views/widgets/reviews_list.dart";
import "package:flutter/material.dart";
import "package:adventure_log/views/pages/filtered_reviews_page_layout.dart";

class IgnoredReviews extends StatefulWidget {
  const IgnoredReviews({super.key});

  @override
  State<IgnoredReviews> createState() => _IgnoredReviewsState();
}

class _IgnoredReviewsState extends State<IgnoredReviews> {
  Future<List<ReviewInfo>> reviews = Future.value(<ReviewInfo>[]);

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  @override
  Widget build(BuildContext context) {
    var header = Align(
      alignment: .topCenter,
      child: constants.headerText("Saved reviews:", context),
    );
    var reviewsList = ReviewsList(reviews, fetchReviews);

    return FilteredReviewsPageLayout(header, reviewsList);
  }

  void fetchReviews() {
    setState(() {
      //reviews = fetchAllReviewsUserIgnored(getCurUserAuth().uid);
    });
  }
}
