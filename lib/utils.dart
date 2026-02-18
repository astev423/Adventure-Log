import 'package:flutter/material.dart';

SizedBox responsiveBox(
  BuildContext context,
  double baseWidth,
  double baseHeight,
) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  final isDesktop = screenWidth >= 800;
  // If phone then swap base and height and multiply base height by aspect ratio conversion
  final boxWidth = isDesktop ? baseWidth : baseHeight * (20 / 16);
  final boxHeight = isDesktop ? baseHeight : baseWidth;

  return SizedBox(
    width: (boxWidth / 200) * screenWidth,
    height: (boxHeight / 200) * screenHeight,
  );
}

Container responsiveContainer(
  BuildContext context,
  double baseWidth,
  double baseHeight,
) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  final isDesktop = screenWidth >= 800;
  // If phone then swap base and height and multiply base height by aspect ratio conversion
  final containerWidth = isDesktop ? baseWidth : baseHeight * (20 / 16);
  final containerHeight = isDesktop ? baseHeight : baseWidth;

  return Container(
    width: (containerWidth / 200) * screenHeight,
    height: (containerHeight / 200) * screenWidth,
  );
}

double responsiveFont(BuildContext context, double base) {
  return base * screenWidth(context) / 200;
}

double screenWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}
