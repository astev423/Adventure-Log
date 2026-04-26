import "package:adventure_log/controllers/utils/constants.dart";
import "package:adventure_log/controllers/utils/responsiveness.dart";
import "package:adventure_log/data/models/review_info.dart";
import "package:adventure_log/views/component_widgets/review_card.dart";
import "package:flutter/material.dart";

class ReviewsList extends StatefulWidget {
  final Future<List<ReviewInfo>> reviews;
  final void Function() refetchReviews;

  const ReviewsList(this.reviews, this.refetchReviews, {super.key});

  @override
  State<ReviewsList> createState() => ReviewsListState();
}

class ReviewsListState extends State<ReviewsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.reviews,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return headerText("An error occured while fetching reviews", context);
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

            return InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                "/view-review",
                arguments: review,
              ),
              child: ReviewCard(review, widget.refetchReviews),
            );
          },
        );
      },
    );
  }
}
