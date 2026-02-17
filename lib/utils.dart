import 'package:flutter/material.dart';

SizedBox responsiveBox(
  BuildContext context,
  double baseWidth,
  double baseHeight,
) {
  final screen_width = MediaQuery.of(context).size.width;
  final screen_height = MediaQuery.of(context).size.height;
  final isDesktop = screen_width >= 800;
  // If phone then swap base and height and multiply base height by aspect ratio conversion
  final boxWidth = isDesktop ? baseWidth : baseHeight * (20 / 16);
  final boxHeight = isDesktop ? baseHeight : baseWidth;

  return SizedBox(
    width: (boxWidth / 200) * screen_width,
    height: (boxHeight / 200) * screen_width,
  );
}

double responsiveFont(BuildContext context, double base) {
  final w = screenWidth(context) / 200;
  return base * w;
}

double screenWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}
