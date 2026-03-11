import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:adventure_log/data/firestore_queries.dart';
import 'package:adventure_log/data/models/review.dart';
import 'package:flutter/material.dart';

class ViewReviews extends StatelessWidget {
  const ViewReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: Center(
        child: Column(
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              child: const Text("Go back to home"),
            ),
            ReviewsColumn(),
          ],
        ),
      ),
    );
  }
}

class ReviewsColumn extends StatefulWidget {
  const ReviewsColumn({super.key});

  @override
  State<ReviewsColumn> createState() => _ReviewsColumnState();
}

class _ReviewsColumnState extends State<ReviewsColumn> {
  List<Review> _reviews = [];

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  void fetchReviews() async {
    var reviews = await fetchAllReviews();
    setState(() {
      if (reviews != null) {
        _reviews = reviews;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchReviews();
    return Column(
      children: [
        Text("Reviews"),
        if (_reviews.isNotEmpty) Text(_reviews[0].locationName),
        if (_reviews.isEmpty) Text("Can't find any ratings"),
      ],
    );
  }
}
