import "../../controllers/utils/constants.dart";
import "../../controllers/utils/responsiveness.dart";
import "../../data/firestore_queries.dart";
import "../../data/models/review_info.dart";
import "../widgets/review_card.dart";
import "package:flutter/material.dart";

class ViewReviews extends StatelessWidget {
  const ViewReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: Center(
        child: Column(
          children: [
            headerText("Reviews", context),
            Text(
              "Click on a review to see it in more detail",
              style: TextStyle(
                color: darkGreen,
                fontSize: responsiveFontSize(context, 20),
              ),
            ),
            SizedBox(
              width: responsiveWidth(context, 900),
              height: responsiveHeight(context, 500),
              child: const _ReviewsList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewsList extends StatefulWidget {
  const _ReviewsList();

  @override
  State<_ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<_ReviewsList> {
  late Future<List<ReviewInfo>> _reviews;

  @override
  void initState() {
    super.initState();
    _reviews = fetchAllReviews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _reviews,
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
