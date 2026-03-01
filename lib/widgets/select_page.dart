import 'package:adventure_log/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectPage extends StatelessWidget {
  final List<(String, VoidCallback)> pagesAndWayToGetThere = [
    ("Explore", () => print("")),
    ("See Reviews", () => print("")),
    ("Add Review", () => print("")),
    ("Profile", () => print("")),
    ("Quit", () => SystemNavigator.pop()),
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
        children: pagesAndWayToGetThere.map((pageAndWayToGetThere) {
          return ElevatedButton(
            onPressed: pageAndWayToGetThere.$2,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: Text(pageAndWayToGetThere.$1, style: textStyle),
          );
        }).toList(),
      ),
    );
  }
}
