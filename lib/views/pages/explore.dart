import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:flutter/material.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: headerText("Explore", context)));
  }
}
