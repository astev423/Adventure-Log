import 'package:adventure_log/controllers/auth/require_login_for_page_wrapper.dart';
import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:adventure_log/data/models/review_info.dart';
import 'package:adventure_log/firebase_options.dart';
import 'package:adventure_log/views/pages/homepage.dart';
import 'package:adventure_log/views/pages/page_wrapper.dart' as wrapper;
import 'package:adventure_log/views/pages/view_review.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
      title: 'Adventure Log',
      theme: ThemeData(scaffoldBackgroundColor: teal),
      onGenerateRoute: _handleRoute,
    );
  }
}

MaterialPageRoute _handleRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/explore':
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(
          child: wrapper.PageWrapper(wrapper.Page.explore),
        ),
      );

    case '/view-reviews':
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(
          child: wrapper.PageWrapper(wrapper.Page.viewReviews),
        ),
      );

    case '/view-review':
      return MaterialPageRoute(
        builder: (_) =>
            ProtectedPage(child: ViewReview(settings.arguments as ReviewInfo)),
      );

    case '/profile':
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(
          child: wrapper.PageWrapper(wrapper.Page.profile),
        ),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const ProtectedPage(child: Homepage()),
      );
  }
}
