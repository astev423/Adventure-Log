import "package:adventure_log/controllers/auth/utils.dart";
import "package:adventure_log/data/models/review_info.dart";
import "package:adventure_log/views/widgets/reviews_list.dart";
import "../../../../controllers/utils/constants.dart";
import "../../../../controllers/utils/responsiveness.dart";
import "package:adventure_log/data/review_queries.dart";
import "package:flutter/material.dart";

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  Future<List<ReviewInfo>> reviews = Future.value(<ReviewInfo>[]);

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Center(
          child: Column(
            children: [
              _ViewReviewsHeader(fetchReviews),
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
                child: ReviewsList(reviews, fetchReviews),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fetchReviews() {
    setState(() {
      reviews = fetchAllVisibleReviewsForCurUser();
    });
  }
}

class _ViewReviewsHeader extends StatelessWidget {
  final void Function() refetchReviews;

  const _ViewReviewsHeader(this.refetchReviews);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(alignment: .topLeft, child: _FilterReviewsOption(refetchReviews)),
        Align(alignment: .topCenter, child: headerText("Reviews", context)),
        Align(
          alignment: .topRight,
          child: appThemedButton(
            context,
            () => switchToRandomReviewPage(context),
            "View a random review",
          ),
        ),
      ],
    );
  }

  void switchToRandomReviewPage(BuildContext context) async {
    final randomReview = await fetchRandomReview();
    if (randomReview == null || !context.mounted) {
      return;
    }

    Navigator.pushNamed(context, "/view-review", arguments: randomReview);
  }
}

class _FilterReviewsOption extends StatefulWidget {
  final void Function() refetchReviews;

  const _FilterReviewsOption(this.refetchReviews);

  @override
  State<_FilterReviewsOption> createState() => _FilterReviewsOptionState();
}

class _FilterReviewsOptionState extends State<_FilterReviewsOption> {
  @override
  Widget build(BuildContext context) {
    return appThemedButton(
      context,
      () => _showReviewsFilterModal(context),
      "Filter reviews",
    );
  }

  Future<dynamic> _showReviewsFilterModal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: grey,
        title: const Text("Filter by:"),
        content: Column(
          mainAxisSize: .min,
          spacing: 5,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(
                    context,
                    "/view-specific-user-reviews",
                    arguments: getCurUserAuth().displayName,
                  );
                  setState(() {
                    widget.refetchReviews();
                  });
                },
                child: const Text("My reviews"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final username = await _showTextInputDialog(context);

                  if (username != null && username.isNotEmpty) {
                    await Navigator.pushNamed(
                      context,
                      "/view-specific-user-reviews",
                      arguments: username,
                    );
                    setState(() {
                      widget.refetchReviews();
                    });
                  }
                },
                child: const Text("Specific user"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, "/view-closest-reviews");
                  setState(() {
                    widget.refetchReviews();
                  });
                },
                child: const Text("Closest to me"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, "/view-newest-reviews");
                  setState(() {
                    widget.refetchReviews();
                  });
                },
                child: const Text("Newest posts first"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, "/view-highest-rated-reviews");
                  setState(() {
                    widget.refetchReviews();
                  });
                },
                child: const Text("Highest rated reviews"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, "/view-saved-reviews");
                  setState(() {
                    widget.refetchReviews();
                  });
                },
                child: const Text("Saved reviews"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, "/view-ignored-reviews");
                  setState(() {
                    widget.refetchReviews();
                  });
                },
                child: const Text("Ignored reviews"),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}

Future<String?> _showTextInputDialog(BuildContext context) async {
  final controller = TextEditingController();

  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Enter text"),
        content: TextField(
          controller: controller,
          autofocus: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (value) {
            Navigator.of(context).pop(value.trim());
          },
          decoration: const InputDecoration(hintText: "Type here"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text("Submit"),
          ),
        ],
      );
    },
  );
}
