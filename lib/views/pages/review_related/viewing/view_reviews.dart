import "package:adventure_log/controllers/auth/utils.dart";
import "package:adventure_log/views/widgets/reviews_list.dart";
import "../../../../controllers/utils/constants.dart";
import "../../../../controllers/utils/responsiveness.dart";
import "package:adventure_log/data/review_queries.dart";
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
                child: ReviewsList(fetchAllVisibleReviewsForCurUser()),
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
                final username = getCurUserAuth();

                Navigator.pushNamed(
                  context,
                  "/view-specific-user-reviews",
                  arguments: username,
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
                    "/view-specific-user-reviews",
                    arguments: username,
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
                  "/view-closest-reviews",
                  arguments: (ReviewsToSee.closestFirst, null),
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
                  "/view-newest-reviews",
                  arguments: (ReviewsToSee.newestFirst, null),
                ),
              },
              child: const Text("Newest posts first"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => {
                Navigator.pushNamed(
                  context,
                  "/view-filtered-reviews",
                  arguments: (ReviewsToSee.saved, null),
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
