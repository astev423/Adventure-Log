import "package:flutter/material.dart";

double screenWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

double responsiveFontSize(BuildContext context, double base) {
  final isDesktop = screenWidth(context) >= 800;

  if (isDesktop) {
    return responsiveWidth(context, base);
  }

  return responsiveWidth(context, base) * 2;
}

double responsiveWidth(BuildContext context, double baseWidth) {
  return screenWidth(context) * baseWidth;
}

double responsiveHeight(BuildContext context, double baseHeight) {
  return screenHeight(context) * baseHeight;
}
