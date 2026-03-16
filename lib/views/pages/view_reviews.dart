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
      body: Column(
        children: [
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/'),
            child: const Text("Go back to home"),
          ),
          SizedBox(height: 10),
          // Expanded tells listbuilder how big it will be as builder needs a size
          Expanded(child: ReviewsList()),
        ],
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
    if (_reviews.isEmpty && _fetchDone) {
      return Center(child: Text("Can't find any ratings"));
    }

    return ListView.builder(
      itemCount: _reviews.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Center(child: Text("Reviews", style: TextStyle(fontSize: 40)));
        }

        final review = _reviews[index - 1];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
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
      width: 600,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          Text(review.locationName),
          Text(review.locationCoordinates),
          StarRating(review.locationRating),
          Text(review.reasonForRating),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  const StarRating(int ratingOutOfFive, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: .min,
      children: [Icon(Icons.star, color: Colors.amber, size: 24.0)],
    );
  }
}
