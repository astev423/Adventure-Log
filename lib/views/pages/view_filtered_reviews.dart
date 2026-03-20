import "package:adventure_log/controllers/utils/constants.dart" as constants;
import "package:adventure_log/controllers/utils/responsiveness.dart";
import "package:adventure_log/data/firestore_queries.dart";
import "package:adventure_log/data/models/review_info.dart";
import "package:adventure_log/views/pages/view_reviews.dart";
import "package:adventure_log/views/widgets/review_card.dart";
import "package:flutter/material.dart";

class ViewFilteredReviews extends StatelessWidget {
  final ReviewsToSee reviewsToSee;
  final String? usernameToSeePostsFrom;

  const ViewFilteredReviews(
    this.reviewsToSee,
    this.usernameToSeePostsFrom, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String headerText = switch (reviewsToSee) {
      ReviewsToSee.specificUser => "Reviews by: $usernameToSeePostsFrom",
      _ => "Reviews by: $usernameToSeePostsFrom",
    };

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
                    child: constants.headerText(headerText, context),
                  ),
                ],
              ),
              SizedBox(
                height: responsiveHeight(context, 600),
                width: responsiveWidth(context, 800),
                child: _ReviewsList(reviewsToSee, usernameToSeePostsFrom),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewsList extends StatefulWidget {
  final ReviewsToSee reviewsToSee;
  final String? usernameToSeePostsFrom;

  const _ReviewsList(this.reviewsToSee, this.usernameToSeePostsFrom);

  @override
  State<_ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<_ReviewsList> {
  late Future<List<ReviewInfo>> _reviews;

  @override
  void initState() {
    super.initState();
    _reviews = switch (widget.reviewsToSee) {
      ReviewsToSee.all => fetchAllReviews(),
      ReviewsToSee.specificUser => fetchAllReviewsFromUser(
        widget.usernameToSeePostsFrom!,
      ),
      ReviewsToSee.closestFirst => fetchAllReviews(),
      ReviewsToSee.newestFirst => fetchAllReviews(),
      ReviewsToSee.saved => fetchAllReviews(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _reviews,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return constants.headerText(
            "An error occured while fetching reviews",
            context,
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final reviews = snapshot.data ?? [];

        return ListView.separated(
          itemCount: reviews.length,
          separatorBuilder: (context, index) {
            return SizedBox(height: responsiveHeight(context, 10));
          },
          itemBuilder: (context, index) {
            final review = reviews[index];

            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: responsiveWidth(context, 800),
                maxHeight: responsiveHeight(context, 600),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  "/view-review",
                  arguments: review,
                ),
                child: ReviewCard(review),
              ),
            );
          },
        );
      },
    );
  }
}
