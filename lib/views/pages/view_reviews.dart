import "package:firebase_auth/firebase_auth.dart";

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
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Center(
          child: Column(
            children: [
              const _ViewReviewsHeader(),
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
      ),
    );
  }
}

enum ReviewsToSee { all, specificUser, closestFirst, newestFirst, saved }

class _ViewReviewsHeader extends StatelessWidget {
  const _ViewReviewsHeader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: .topLeft,
          child: appThemedButton(
            () => _showReviewsFilterModal(context),
            "Filter reviews",
          ),
        ),
        Align(alignment: .topCenter, child: headerText("Reviews", context)),
        const SizedBox(),
      ],
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
                final username =
                    FirebaseAuth.instance.currentUser!.displayName!;

                Navigator.pushNamed(
                  context,
                  "/view-filtered-reviews",
                  arguments: (ReviewsToSee.specificUser, username),
                );
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
                  Navigator.pushNamed(
                    context,
                    "/view-filtered-reviews",
                    arguments: (ReviewsToSee.specificUser, username),
                  );
                }
              },
              child: const Text("Specific user"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => {
                Navigator.pushNamed(
                  context,
                  "/view-filtered-reviews",
                  arguments: (ReviewsToSee.closestFirst),
                ),
              },
              child: const Text("Closest to me"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => {
                Navigator.pushNamed(
                  context,
                  "/view-filtered-reviews",
                  arguments: (ReviewsToSee.newestFirst),
                ),
              },
              child: const Text("Date posted"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => {
                Navigator.pushNamed(
                  context,
                  "/view-filtered-reviews",
                  arguments: (ReviewsToSee.saved),
                ),
              },
              child: const Text("Saved reviews"),
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
