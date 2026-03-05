import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:adventure_log/views/pages/add_review.dart';
import 'package:adventure_log/views/pages/explore.dart';
import 'package:adventure_log/views/pages/profile.dart';
import 'package:adventure_log/views/pages/view_reviews.dart';
import 'package:flutter/material.dart';

enum Page { explore, viewReviews, addReview, profile }

class PageWrapper extends StatefulWidget {
  final Page initialPage;

  const PageWrapper(this.initialPage, {super.key});

  @override
  State<PageWrapper> createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  final List<Widget> _pages = [
    Explore(),
    ViewReviews(),
    AddReview(),
    Profile(),
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
              Tab(icon: Icon(Icons.search), text: 'Explore'),
              Tab(icon: Icon(Icons.remove_red_eye), text: 'View Reviews'),
              Tab(icon: Icon(Icons.add), text: 'Add Review'),
              Tab(icon: Icon(Icons.settings), text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(children: _pages),
      ),
    );
  }
}
