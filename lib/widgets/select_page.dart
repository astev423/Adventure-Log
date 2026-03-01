import 'package:adventure_log/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: const Color(0xFF4C956C),
      fontWeight: .w400,
      fontSize: responsiveFontSize(context, 60),
    );
    final List<(String, VoidCallback)> pagesAndRoutes = [
      ("Explore", () => Navigator.pushNamed(context, '/explore')),
      ("View Reviews", () => Navigator.pushNamed(context, '/view-reviews')),
      ("Add Review", () => Navigator.pushNamed(context, '/add-review')),
      ("Profile", () => Navigator.pushNamed(context, '/profile')),
      ("Quit", () => SystemNavigator.pop()),
    ];

    return SizedBox(
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: .stretch,
        children: pagesAndRoutes.map((pageAndRoute) {
          return ElevatedButton(
            onPressed: pageAndRoute.$2,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: Text(pageAndRoute.$1, style: textStyle),
          );
        }).toList(),
      ),
    );
  }
}
