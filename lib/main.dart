import "package:adventure_log/views/pages/review_related/viewing/closest_reviews.dart";
import "package:adventure_log/views/pages/review_related/viewing/highest_rated_reviews.dart";
import "package:adventure_log/views/pages/review_related/viewing/newest_reviews.dart";
import "package:adventure_log/views/pages/review_related/viewing/saved_reviews.dart";
import "package:adventure_log/views/pages/review_related/viewing/specific_user_reviews.dart";
import "controllers/auth/require_login_for_page_wrapper.dart";
import "controllers/utils/constants.dart";
import "data/models/review_info.dart";
import "../firebase_options.dart";
import "views/pages/home.dart";
import "views/pages/page_wrapper.dart" as wrapper;
import "views/pages/review_related/viewing/review.dart";
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

    case "/view-newest-reviews":
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(child: NewestReviews()),
      );

    case "/view-saved-reviews":
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(child: SavedReviews()),
      );

    case "/view-highest-rated-reviews":
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(child: HighestRatedReviews()),
      );

    case "/view-closest-reviews":
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(child: ClosestReviews()),
      );

    case "/view-specific-user-reviews":
      final username = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => ProtectedPage(child: SpecificUserReviews(username)),
      );

    case "/view-review":
      return MaterialPageRoute(
        builder: (_) =>
            ProtectedPage(child: Review(settings.arguments as ReviewInfo)),
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
