import 'package:adventure_log/constants.dart';
import 'package:adventure_log/pages/homepage.dart';
import 'package:adventure_log/pages/page_wrapper.dart' as wrapper;
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
      theme: ThemeData(scaffoldBackgroundColor: teal),
      initialRoute: '/',
      routes: {
        '/explore': (context) =>
            const wrapper.PageWrapper(wrapper.Page.explore),
        '/view-reviews': (context) =>
            const wrapper.PageWrapper(wrapper.Page.viewReviews),
        '/add-review': (context) =>
            const wrapper.PageWrapper(wrapper.Page.addReview),
        '/profile': (context) =>
            const wrapper.PageWrapper(wrapper.Page.profile),
      },
      home: const Homepage(),
    );
  }
}
