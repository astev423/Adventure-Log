import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:adventure_log/controllers/utils/responsiveness.dart';
import 'package:adventure_log/views/widgets/select_page.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          fit: StackFit.expand,
          children: [
            BlurredMountainBackgroundImage(),
            Column(
              children: [
                Text(
                  "Adventure Log",
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: responsiveFontSize(context, 160),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "Log and find amazing places!",
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: responsiveFontSize(context, 60),
                  ),
                ),
                NavigationButtons(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: responsiveWidth(context, 900),
        child: Center(child: SelectPage()),
      ),
    );
  }
}

class BlurredMountainBackgroundImage extends StatelessWidget {
  const BlurredMountainBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.05,
      child: Image.asset('assets/images/lake-landscape.jpg', fit: BoxFit.cover),
    );
  }
}
