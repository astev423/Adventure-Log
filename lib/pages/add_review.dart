import 'package:flutter/material.dart';

class AddReview extends StatelessWidget {
  const AddReview({super.key});

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
