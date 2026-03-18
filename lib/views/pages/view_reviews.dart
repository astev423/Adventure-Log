import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:adventure_log/controllers/utils/responsiveness.dart';
import 'package:adventure_log/data/firestore_queries.dart';
import 'package:adventure_log/data/models/review_info.dart';
import 'package:adventure_log/views/widgets/review_card.dart';
import 'package:flutter/material.dart';

class ViewReviews extends StatelessWidget {
  const ViewReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            // Expanded tells listbuilder how big it will be as builder needs a size
            Expanded(
              child: SizedBox(
                width: responsiveWidth(context, 1200),
                child: ReviewsList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewsList extends StatefulWidget {
  const ReviewsList({super.key});

  @override
  State<ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  List<ReviewInfo> _reviews = [];
  bool _isFetchDone = false;

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  void fetchReviews() async {
    List<ReviewInfo> reviews = await fetchAllReviews();
    setState(() {
      _reviews = reviews;
      _isFetchDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isFetchDone) {
      return Center(child: headerText("Loading reviews...", context));
    }
    if (_reviews.isEmpty) {
      return Center(child: headerText("Can't find any ratings", context));
    }

    return ListView.builder(
      itemCount: _reviews.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Center(child: headerText("Reviews", context));
        }

        final review = _reviews[index - 1];
        return Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: ReviewCard(review),
        );
      },
    );
  }
}
