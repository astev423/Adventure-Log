import "package:adventure_log/controllers/utils/constants.dart" as constants;
import "package:adventure_log/controllers/utils/responsiveness.dart";
import "package:flutter/material.dart";

class FilteredReviewsPageLayout extends StatelessWidget {
  final Align header;
  final Widget body;

  const FilteredReviewsPageLayout(this.header, this.body, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.teal,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            spacing: 20,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: .topLeft,
                    child: constants.appThemedButton(
                      () => Navigator.pop(context),
                      "Click here to go back!",
                    ),
                  ),
                  header,
                ],
              ),
              SizedBox(
                height: responsiveHeight(context, 600),
                width: responsiveWidth(context, 800),
                child: body,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
