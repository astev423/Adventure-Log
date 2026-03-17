import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:adventure_log/controllers/utils/responsiveness.dart';
import 'package:adventure_log/data/firestore_queries.dart';
import 'package:adventure_log/data/models/review_info.dart';
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
  bool _fetchDone = false;

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  void fetchReviews() async {
    List<ReviewInfo> reviews = await fetchAllReviews();
    setState(() {
      _reviews = reviews;
      _fetchDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_fetchDone) {
      return Center(
        child: Text("Loading reviews...", style: TextStyle(fontSize: 40)),
      );
    }
    if (_reviews.isEmpty) {
      return Center(
        child: Text("Can't find any ratings", style: TextStyle(fontSize: 40)),
      );
    }

    return ListView.builder(
      itemCount: _reviews.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Center(child: Text("Reviews", style: TextStyle(fontSize: 40)));
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

class ReviewCard extends StatelessWidget {
  const ReviewCard(this.review, {super.key});

  final ReviewInfo review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          Text(review.locationName),
          Text(review.locationCoordinates),
          if (review.imageURL != null)
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600, maxHeight: 400),
              child: Image(image: NetworkImage(review.imageURL!)),
            ),
          StarRating(review.locationRating),
          if (review.reasonForRating != null) Text(review.reasonForRating!),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int _ratingOutOfFive;
  const StarRating(this._ratingOutOfFive, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      children: [
        for (int starIndex = 0; starIndex < 5; ++starIndex)
          Icon(
            starIndex + 1 > _ratingOutOfFive ? Icons.star_border : Icons.star,
            color: Colors.amber,
            size: 24.0,
          ),
      ],
    );
  }
}
