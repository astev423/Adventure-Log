import 'package:adventure_log/pages/add_review.dart';
import 'package:adventure_log/pages/explore.dart';
import 'package:adventure_log/pages/homepage.dart';
import 'package:adventure_log/pages/profile.dart';
import 'package:adventure_log/pages/view_reviews.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adventure Log',
      initialRoute: '/',
      routes: {
        '/explore': (context) => const Explore(),
        '/view-reviews': (context) => const ViewReviews(),
        '/add-review': (context) => const AddReview(),
        '/profile': (context) => const Profile(),
      },
      home: const Homepage(),
    );
  }
}
