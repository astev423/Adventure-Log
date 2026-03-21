import "../../controllers/utils/constants.dart";
import "review_related/creating/add_review.dart";
import "explore.dart";
import "profile.dart";
import "review_related/viewing/reviews.dart";
import "package:flutter/material.dart";

enum Page { explore, viewReviews, addReview, profile }

class PageWrapper extends StatefulWidget {
  final Page initialPage;

  const PageWrapper(this.initialPage, {super.key});

  @override
  State<PageWrapper> createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  final List<Widget> _pages = [
    const Explore(),
    const Reviews(),
    const AddReview(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: widget.initialPage.index,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: darkGreen,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.search), text: "Explore"),
              Tab(icon: Icon(Icons.remove_red_eye), text: "View Reviews"),
              Tab(icon: Icon(Icons.add), text: "Add Review"),
              Tab(icon: Icon(Icons.settings), text: "Profile"),
            ],
          ),
        ),
        body: TabBarView(children: _pages),
      ),
    );
  }
}
