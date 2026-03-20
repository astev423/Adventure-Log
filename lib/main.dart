import "package:adventure_log/views/pages/view_filtered_reviews.dart";
import "package:adventure_log/views/pages/view_reviews.dart";

import "controllers/auth/require_login_for_page_wrapper.dart";
import "controllers/utils/constants.dart";
import "data/models/review_info.dart";
import "../firebase_options.dart";
import "views/pages/home.dart";
import "views/pages/page_wrapper.dart" as wrapper;
import "views/pages/view_review.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Adventure Log",
      theme: ThemeData(scaffoldBackgroundColor: teal),
      onGenerateRoute: _handleRoute,
    );
  }
}

MaterialPageRoute<dynamic> _handleRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/explore":
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(
          child: wrapper.PageWrapper(wrapper.Page.explore),
        ),
      );

    case "/view-reviews":
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(
          child: wrapper.PageWrapper(wrapper.Page.viewReviews),
        ),
      );

    case "/view-filtered-reviews":
      final args =
          settings.arguments
              as (ReviewsToSee reviewsToSee, String usernameToSeePostsFrom);
      return MaterialPageRoute(
        builder: (_) =>
            ProtectedPage(child: ViewFilteredReviews(args.$1, args.$2)),
      );

    case "/view-review":
      return MaterialPageRoute(
        builder: (_) =>
            ProtectedPage(child: ViewReview(settings.arguments as ReviewInfo)),
      );

    case "/add-review":
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(
          child: wrapper.PageWrapper(wrapper.Page.addReview),
        ),
      );

    case "/profile":
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(
          child: wrapper.PageWrapper(wrapper.Page.profile),
        ),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(child: Home()),
      );
  }
}
