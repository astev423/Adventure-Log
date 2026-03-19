import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:adventure_log/controllers/utils/responsiveness.dart';
import 'package:adventure_log/data/firestore_queries.dart';
import 'package:adventure_log/data/models/review_info.dart';
import 'package:adventure_log/views/widgets/review_card.dart';
import 'package:flutter/material.dart';

class ViewReviews extends StatelessWidget {
  const ViewReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: Center(
        child: Column(
          spacing: responsiveHeight(context, 20),
          children: [
            headerText("Reviews", context),
            SizedBox(
              width: responsiveWidth(context, 1200),
              height: responsiveHeight(context, 1100),
              child: _ReviewsList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewsList extends StatefulWidget {
  const _ReviewsList();

  @override
  State<_ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<_ReviewsList> {
  List<ReviewInfo> _reviews = [];
  bool _isFetchDone = false;

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  void fetchReviews() async {
    List<ReviewInfo> reviews = await fetchAllReviews();
    setState(() {
      _reviews = reviews;
      _isFetchDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isFetchDone) {
      return Center(child: headerText("Loading reviews...", context));
    }
    if (_reviews.isEmpty) {
      return Center(child: headerText("Can't find any ratings", context));
    }

    return ListView.separated(
      itemCount: _reviews.length,
      separatorBuilder: (context, index) {
        return responsiveBox(context, 10);
      },
      itemBuilder: (context, index) {
        return ReviewCard(_reviews[index]);
      },
    );
  }
}
