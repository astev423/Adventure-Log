import "../../controllers/utils/constants.dart";
import "../../controllers/utils/responsiveness.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

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
            const _BlurredMountainBackgroundImage(),
            Column(
              children: [
                Text(
                  "Adventure Log",
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: responsiveFontSize(context, 70),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "Log and find amazing places!",
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: responsiveFontSize(context, 40),
                  ),
                ),
                const _NavigationButtons(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationButtons extends StatelessWidget {
  const _NavigationButtons();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: responsiveWidth(context, 900),
        child: const Center(child: _SelectPage()),
      ),
    );
  }
}

class _SelectPage extends StatelessWidget {
  const _SelectPage();

  @override
  Widget build(BuildContext context) {
    final List<(String, VoidCallback)> pagesAndRoutes = [
      ("Explore", () => Navigator.pushNamed(context, "/explore")),
      ("View Reviews", () => Navigator.pushNamed(context, "/view-reviews")),
      ("Add Review", () => Navigator.pushNamed(context, "/add-review")),
      ("Profile", () => Navigator.pushNamed(context, "/profile")),
      ("Quit", () => SystemNavigator.pop()),
    ];

    return SizedBox(
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: .stretch,
        children: pagesAndRoutes.map((pageAndRoute) {
          return ElevatedButton(
            onPressed: pageAndRoute.$2,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: Text(
              pageAndRoute.$1,
              style: TextStyle(
                color: darkGreen,
                fontWeight: .w400,
                fontSize: responsiveFontSize(context, 40),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _BlurredMountainBackgroundImage extends StatelessWidget {
  const _BlurredMountainBackgroundImage();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.05,
      child: Image.asset("assets/images/lake-landscape.jpg", fit: BoxFit.cover),
    );
  }
}
