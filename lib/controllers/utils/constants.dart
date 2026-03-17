import 'package:adventure_log/controllers/utils/responsiveness.dart';
import 'package:flutter/material.dart';

const darkGreen = Color(0xFF2C6E49);
const teal = Color(0xFFA4C3B2);
const greyTeal = Color(0xFFCCE3DE);
const grey = Color(0xFFEAF4F4);
const mint = Color(0xFFF6FFF8);

Text headerText(String text, BuildContext context) {
  return Text(
    text,
    style: TextStyle(
      fontSize: responsiveFontSize(context, 40),
      fontWeight: .bold,
      color: darkGreen,
    ),
  );
}
