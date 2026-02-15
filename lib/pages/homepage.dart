import 'package:adventure_log/utils.dart';
import 'package:adventure_log/widgets/select_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final normalTextStyle = TextStyle(
      color: const Color(0xFF4C956C),
      fontSize: responsiveFont(context, 8),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEE3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Adventure Log",
              style: TextStyle(
                color: const Color(0xFF2C6E49),
                fontSize: responsiveFont(context, 20),
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 12, width: 12),
            Text("Log and find amazing places!", style: normalTextStyle),
            SizedBox(height: 80, width: 80),
            SelectPage(textStyle: normalTextStyle),
            SizedBox(height: 160, width: 160),
          ],
        ),
      ),
    );
  }
}
