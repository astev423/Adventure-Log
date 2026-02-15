import 'package:flutter/material.dart';

double responsiveFont(BuildContext context, double base) {
  final w = MediaQuery.sizeOf(context).width / 200;
  return base * w;
}
