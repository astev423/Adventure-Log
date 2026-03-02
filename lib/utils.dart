import 'package:flutter/material.dart';

// For padding between items, for same look phone must pad height more (with respect to width)
SizedBox responsiveBox(BuildContext context, double size) {
  double baseWidth = size;
  double baseHeight = size;
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  final isDesktop = screenWidth >= 800;
  // If phone then swap base and height and multiply base height by aspect ratio conversion
  final boxWidth = isDesktop ? baseWidth : baseHeight;
  final boxHeight = isDesktop ? baseHeight : baseWidth * (20 / 16);

  return SizedBox(
    width: (boxWidth / 200) * screenWidth,
    height: (boxHeight / 200) * screenHeight,
  );
}

double responsiveFontSize(BuildContext context, double base) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isDesktop = screenWidth >= 800;
  if (isDesktop) {
    return responsiveWidth(context, base);
  } else {
    return responsiveWidth(context, base) * 2;
  }
}

double screenWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

double responsiveWidth(BuildContext context, double baseWidth) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isDesktop = screenWidth >= 800;

  if (isDesktop) {
    return baseWidth * (screenWidth / 1700);
  } else {
    return baseWidth * (screenWidth / 1500);
  }
}

double responsiveHeight(BuildContext context, double baseHeight) {
  return baseHeight * (screenWidth(context) / 200);
}

String? requireNonEmptyString(String? v) {
  if (v == null || v.trim().isEmpty) {
    return 'Text required here';
  }

  return null;
}

String? requireNumber(String? v, {bool singleDigit = false}) {
  if (v == null || v.trim().isEmpty) {
    return 'Input required';
  }

  var inputAsNum = num.tryParse(v);
  if (inputAsNum == null) {
    return 'Must enter a valid number';
  }

  if (singleDigit && (inputAsNum < 0 || inputAsNum > 9)) {
    return 'Only enter one positive digit';
  }

  return null;
}
