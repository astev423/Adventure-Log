import 'package:adventure_log/utils.dart';
import 'package:flutter/material.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: const Color(0xFF4C956C),
      fontWeight: .w400,
      fontSize: responsiveFont(context, 10),
    );

    return SizedBox(
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: .stretch,
        children: [
          ElevatedButton(
            onPressed: () => print(""),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: Text("Rate aa place", style: textStyle),
          ),
          ElevatedButton(
            onPressed: () => print(""),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: Text("View ratings", style: textStyle),
          ),
        ],
      ),
    );
  }
}
