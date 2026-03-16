import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:adventure_log/firebase_options.dart';
import 'package:adventure_log/views/pages/auth_page.dart';
import 'package:adventure_log/views/pages/homepage.dart';
import 'package:adventure_log/views/pages/page_wrapper.dart' as wrapper;
import 'package:firebase_auth/firebase_auth.dart';
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
      home: const AuthGate(),
      onGenerateRoute: (settings) {
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

          case '/add-review':
            return MaterialPageRoute(
              builder: (_) => const ProtectedPage(
                child: wrapper.PageWrapper(wrapper.Page.addReview),
              ),
            );

          case '/profile':
            return MaterialPageRoute(
              builder: (_) => const ProtectedPage(
                child: wrapper.PageWrapper(wrapper.Page.profile),
              ),
            );

          default:
            return MaterialPageRoute(builder: (_) => const AuthGate());
        }
      },
    );
  }
}

class ProtectedPage extends StatelessWidget {
  final Widget child;

  const ProtectedPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return child;
        }

        return const AuthPage();
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const Homepage();
        }

        return const AuthPage();
      },
    );
  }
}
