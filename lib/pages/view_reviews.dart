import 'package:adventure_log/constants.dart';
import 'package:flutter/material.dart';

class ViewReviews extends StatelessWidget {
  const ViewReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/'),
          child: Text("Go back to home"),
        ),
      ),
    );
  }
}
