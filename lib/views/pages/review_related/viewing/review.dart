import "package:adventure_log/data/review_queries.dart";
import "../../../../controllers/utils/constants.dart";
import "../../../../controllers/utils/responsiveness.dart";
import "../../../../data/models/review_info.dart";
import "../../../widgets/review_card.dart";
import "package:flutter/material.dart";

class Review extends StatefulWidget {
  final ReviewInfo review;

  const Review(this.review, {super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  late Future<ReviewInfo?> reviewFuture;

  @override
  void initState() {
    super.initState();
    reviewFuture = fetchReviewById(widget.review.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            spacing: 20,
            children: [
              Row(
                children: [
                  appThemedButton(
                    () => Navigator.pop(context),
                    "Click here to go back!",
                  ),
                ],
              ),
              SizedBox(
                height: responsiveHeight(context, 600),
                width: responsiveWidth(context, 800),
                child: FutureBuilder<ReviewInfo?>(
                  future: reviewFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .start,
                        children: [headerText("Review not found", context)],
                      );
                    }

                    return SingleChildScrollView(
                      child: ReviewCard(snapshot.data!, refreshReview),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> refreshReview() async {
    setState(() {
      reviewFuture = fetchReviewById(widget.review.id!);
    });
  }
}
