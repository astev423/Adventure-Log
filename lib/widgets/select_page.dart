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
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () => print(""),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: Text("Rate a place", style: textStyle),
          ),
          const SizedBox(height: 12),
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
