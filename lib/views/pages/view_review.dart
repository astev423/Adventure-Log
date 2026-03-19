import "../../controllers/utils/constants.dart";
import "../../controllers/utils/responsiveness.dart";
import "../../data/models/review_info.dart";
import "../widgets/review_card.dart";
import "package:flutter/material.dart";

class ViewReview extends StatelessWidget {
  final ReviewInfo review;

  const ViewReview(this.review, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            spacing: 10,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Click here to go back!",
                      style: TextStyle(
                        fontSize: responsiveFontSize(context, 20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: responsiveHeight(context, 500),
                child: SingleChildScrollView(child: ReviewCard(review)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
