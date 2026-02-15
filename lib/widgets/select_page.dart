import 'package:flutter/material.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key, required this.textStyle});
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Rate a place", style: textStyle),
        SizedBox(height: 12, width: 12),
        Text("View ratings for places", style: textStyle),
      ],
    );
  }
}
