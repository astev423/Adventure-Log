import 'package:adventure_log/constants.dart';
import 'package:adventure_log/utils.dart';
import 'package:adventure_log/widgets/select_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA4C3B2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Adventure Log",
              style: TextStyle(
                color: DARK_GREEN,
                fontSize: responsiveFont(context, 20),
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 12, width: 12),
            Text(
              "Log and find amazing places!",
              style: TextStyle(
                color: DARK_GREEN,
                fontSize: responsiveFont(context, 8),
              ),
            ),
            SizedBox(height: 80, width: 80),
            SelectPage(),
            SizedBox(height: 160, width: 160),
          ],
        ),
      ),
    );
  }
}
