import "package:adventure_log/controllers/utils/constants.dart";
import "package:adventure_log/data/user_queries.dart";
import "../../controllers/utils/responsiveness.dart";
import "../../data/models/review_info.dart";
import "package:flutter/material.dart";

class ReviewCard extends StatelessWidget {
  final ReviewInfo review;

  const ReviewCard(this.review, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 80, right: 80),
      color: mint,
      child: Column(
        mainAxisSize: .min,
        children: [
          _ReviewTitle(review),
          _PosterInfo(review),
          Text(review.locationCoordinates),
          if (review.imageURL != null)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600, maxHeight: 400),
              child: Image(image: NetworkImage(review.imageURL!)),
            ),
          _StarRating(review.locationRating),
          Text(review.reasonForRating ?? "", overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

class _PosterInfo extends StatefulWidget {
  final ReviewInfo review;

  const _PosterInfo(this.review);

  @override
  State<_PosterInfo> createState() => _PosterInfoState();
}

class _PosterInfoState extends State<_PosterInfo> {
  String? _profPicURL;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Review by: ${widget.review.posterUsername}"),
        if (_profPicURL != null)
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: responsiveHeight(context, 50),
              maxWidth: responsiveWidth(context, 50),
            ),
            child: Image(image: NetworkImage(_profPicURL!)),
          ),
      ],
    );
  }

  void _getCurUserData() async {
    final userData = await getCurUserData();
    setState(() {
      _profPicURL = userData.profilePictureURL;
    });
  }
}

class _ReviewTitle extends StatelessWidget {
  final ReviewInfo review;

  const _ReviewTitle(this.review);

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: .center,
      children: [
        Text(
          review.locationName,
          style: TextStyle(
            fontSize: responsiveFontSize(context, 20),
            fontWeight: .bold,
          ),
        ),
        if (!review.isPublic)
          const Tooltip(
            message: "Private: Only you can see this review",
            child: Icon(Icons.lock),
          ),
      ],
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
