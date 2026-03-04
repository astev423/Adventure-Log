import 'package:adventure_log/utils/constants.dart';
import 'package:adventure_log/utils/responsiveness.dart';
import 'package:adventure_log/widgets/select_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          fit: StackFit.expand,
          children: [
            BlurredMountainBackgroundImage(),
            Column(
              children: [AppTitle(), AppDescription(), NavigationButtons()],
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

class AppDescription extends StatelessWidget {
  const AppDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Log and find amazing places!",
      style: TextStyle(
        color: darkGreen,
        fontSize: responsiveFontSize(context, 60),
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Adventure Log",
      style: TextStyle(
        color: darkGreen,
        fontSize: responsiveFontSize(context, 160),
        fontWeight: FontWeight.w900,
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
