import "package:adventure_log/controllers/auth/utils.dart";
import "package:adventure_log/controllers/utils/constants.dart";
import "package:adventure_log/data/models/user.dart";
import "package:adventure_log/data/review_queries.dart";
import "package:adventure_log/data/user_queries.dart";
import "../../controllers/utils/responsiveness.dart";
import "../../data/models/review_info.dart";
import "package:flutter/material.dart";

class ReviewCard extends StatelessWidget {
  final ReviewInfo review;
  final void Function() refetchReviews;

  const ReviewCard(this.review, this.refetchReviews, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 80, right: 80),
      color: mint,
      child: Column(
        mainAxisSize: .min,
        children: [
          _ReviewHeader(review, refetchReviews),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Text("Review by: ${widget.review.posterUsername}"),
        if (widget.review.profilePictureURL != null)
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: responsiveHeight(context, 50),
              maxWidth: responsiveWidth(context, 50),
            ),
            child: Image(image: NetworkImage(widget.review.profilePictureURL!)),
          ),
      ],
    );
  }
}

class _ReviewHeader extends StatefulWidget {
  final ReviewInfo review;
  final void Function() refetchReviews;

  const _ReviewHeader(this.review, this.refetchReviews);

  @override
  State<_ReviewHeader> createState() => __ReviewHeaderState();
}

class __ReviewHeaderState extends State<_ReviewHeader> {
  User? _userData;
  bool? _isReviewSaved;
  bool? _isReviewIgnored;

  @override
  void initState() {
    super.initState();
    _setCurUserData();
    _checkIfReviewIsSaved();
    _checkIfReviewIsIgnored();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width < 850) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                widget.review.locationName,
                style: TextStyle(
                  fontSize: responsiveFontSize(context, 20),
                  fontWeight: .bold,
                ),
              ),
              if (!widget.review.isPublic)
                const Tooltip(
                  message: "Private: Only you can see this review",
                  child: Icon(Icons.lock),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: .center,
            children: [
              _reviewSaveButton(),
              _reviewIgnoreButton(),
              if (_userData != null &&
                  _userData!.username == widget.review.posterUsername)
                Row(
                  mainAxisAlignment: .end,
                  children: [
                    _DeletePostButton(widget.review.id!, widget.refetchReviews),
                  ],
                ),
            ],
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Expanded(
          child: Center(
            // If review saved show green icon, if not saved show red, if loading show nothing
            child: Row(
              mainAxisSize: .min,
              children: [_reviewSaveButton(), _reviewIgnoreButton()],
            ),
          ),
        ),
        Row(
          children: [
            Text(
              widget.review.locationName,
              style: TextStyle(
                fontSize: responsiveFontSize(context, 20),
                fontWeight: .bold,
              ),
            ),
            if (!widget.review.isPublic)
              const Tooltip(
                message: "Private: Only you can see this review",
                child: Icon(Icons.lock),
              ),
          ],
        ),
        if (_userData != null &&
            _userData!.username == widget.review.posterUsername)
          Expanded(
            child: Row(
              mainAxisAlignment: .end,
              children: [
                _DeletePostButton(widget.review.id!, widget.refetchReviews),
              ],
            ),
          )
        else
          const Spacer(),
      ],
    );
  }

  void _setCurUserData() async {
    _userData = await getCurUserData();
    setState(() {
      _userData = _userData;
    });
  }

  void _checkIfReviewIsSaved() async {
    _isReviewSaved = await isReviewSaved(
      widget.review.id!,
      getCurUserAuth().uid,
    );
    setState(() {
      _isReviewSaved = _isReviewSaved;
    });
  }

  void _checkIfReviewIsIgnored() async {
    _isReviewIgnored = await isReviewIgnored(
      widget.review.id!,
      getCurUserAuth().uid,
    );
    setState(() {
      _isReviewIgnored = _isReviewIgnored;
    });
  }

  Widget _reviewSaveButton() {
    if (_isReviewSaved == null) {
      return const SizedBox();
    }

    return IconButton(
      onPressed: () {
        if (_isReviewSaved! == true) {
          tryRemovingSavedReview(widget.review.id!, getCurUserAuth().uid);
        } else {
          addSavedReview(widget.review, getCurUserAuth().uid);
        }

        widget.refetchReviews();
      },
      icon: Icon(
        Icons.save,
        color: _isReviewSaved! ? Colors.greenAccent : Colors.red,
        size: 30,
      ),
      tooltip: _isReviewSaved! ? "Unsave review" : "Save review",
    );
  }

  Widget _reviewIgnoreButton() {
    if (_isReviewIgnored == null) {
      return const SizedBox();
    }

    return IconButton(
      onPressed: () {
        if (_isReviewIgnored! == true) {
          tryRemovingIgnoredReview(widget.review.id!, getCurUserAuth().uid);
        } else {
          addIgnoredReview(widget.review, getCurUserAuth().uid);
        }

        widget.refetchReviews();
      },
      icon: _isReviewIgnored!
          ? const Icon(Icons.visibility_off, color: Colors.red, size: 30)
          : const Icon(Icons.visibility, color: Colors.greenAccent, size: 30),
      tooltip: _isReviewIgnored! ? "Review ignored" : "Review is visible",
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

class _DeletePostButton extends StatelessWidget {
  final String _reviewId;
  final void Function() refetchReviews;

  const _DeletePostButton(this._reviewId, this.refetchReviews);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _confirmDeletion(context);
      },
      icon: const Icon(Icons.cancel, color: Colors.red),
      iconSize: 25,
    );
  }

  Future<void> _confirmDeletion(BuildContext context) async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete review?"),
          content: const Text("Are you sure you want to delete this review?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      tryDeleteReview(_reviewId);
      refetchReviews();
    }
  }
}
