import "package:flutter/material.dart";

double responsiveFontSize(BuildContext context, double base) {
  final isDesktop = MediaQuery.sizeOf(context).width >= 800;

  if (isDesktop) {
    return responsiveWidth(context, base);
  }

  return responsiveWidth(context, base) * 2;
}

double responsiveWidth(BuildContext context, double baseWidth) {
  return (MediaQuery.sizeOf(context).width * baseWidth) / 1370;
}

double responsiveHeight(BuildContext context, double baseHeight) {
  return (MediaQuery.sizeOf(context).height * baseHeight) / 770;
}
