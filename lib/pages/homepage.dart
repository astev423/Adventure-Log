import 'package:adventure_log/constants.dart';
import 'package:adventure_log/utils.dart';
import 'package:adventure_log/widgets/select_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TEAL,
      body: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/images/lake-landscape.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Text(
                  "Adventure Log",
                  style: TextStyle(
                    color: DARK_GREEN,
                    fontSize: responsiveFontSize(context, 160),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "Log and find amazing places!",
                  style: TextStyle(
                    color: DARK_GREEN,
                    fontSize: responsiveFontSize(context, 60),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: responsiveWidth(context, 900),
                    child: Center(child: SelectPage()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
