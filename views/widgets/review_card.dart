import "../../controllers/utils/responsiveness.dart";
import "../../data/models/review_info.dart";
import "package:flutter/material.dart";

class ReviewCard extends StatelessWidget {
  const ReviewCard(this.review, {super.key});

  final ReviewInfo review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 80, right: 80),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            review.locationName,
            style: TextStyle(
              fontSize: responsiveFontSize(context, 20),
              fontWeight: .bold,
            ),
          ),
          Text("Review by: ${review.posterUsername}"),
          Text(review.locationCoordinates),
          if (review.imageURL != null)
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600, maxHeight: 400),
              child: Image(image: NetworkImage(review.imageURL!)),
            ),
          _StarRating(review.locationRating),
          if (review.reasonForRating != null) Text(review.reasonForRating!),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  final int _ratingOutOfFive;
  const _StarRating(this._ratingOutOfFive);

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
