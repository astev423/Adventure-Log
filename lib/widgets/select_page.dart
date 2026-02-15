import 'package:adventure_log/utils.dart';
import 'package:flutter/material.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => print("hello"),
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFC9B9)),
          child: Text(
            "Rate a place",
            style: TextStyle(
              color: const Color(0xFF4C956C),
              fontSize: responsiveFont(context, 8),
            ),
          ),
        ),
        SizedBox(height: 12, width: 12),
        ElevatedButton(
          onPressed: () => print(""),
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFC9B9)),
          child: Text(
            "View ratings for places",
            style: TextStyle(
              color: const Color(0xFF4C956C),
              fontWeight: .w900,
              fontSize: responsiveFont(context, 12),
            ),
          ),
        ),
      ],
    );
  }
}
