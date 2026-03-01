import 'package:adventure_log/utils.dart';
import 'package:flutter/material.dart';

class SelectPage extends StatelessWidget {
  final List<String> pages = [
    "Explore",
    "See Reviews",
    "Add Review",
    "Profile",
    "Quit",
  ];

  SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: const Color(0xFF4C956C),
      fontWeight: .w400,
      fontSize: responsiveFontSize(context, 60),
    );

    return SizedBox(
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: .stretch,
        children: pages.map((page) {
          return ElevatedButton(
            onPressed: () => print(""),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: Text(page, style: textStyle),
          );
        }).toList(),
      ),
    );
  }
}
