import 'package:adventure_log/utils/constants.dart';
import 'package:adventure_log/utils/responsiveness.dart';
import 'package:adventure_log/utils/validators.dart';
import 'package:flutter/material.dart';

class AddReview extends StatelessWidget {
  const AddReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: Center(
        child: Column(
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              child: const Text("Go back to home"),
            ),
            AddReviewForm(),
          ],
        ),
      ),
    );
  }
}

class AddReviewForm extends StatefulWidget {
  const AddReviewForm({super.key});

  @override
  State<AddReviewForm> createState() {
    return _AddReviewFormState();
  }
}

class _AddReviewFormState extends State<AddReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _locationNameCtl = TextEditingController();
  final _locationCoordsCtl = TextEditingController();
  final _locationRatingCtl = TextEditingController();
  final _locationRatingReasonCtl = TextEditingController();

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Sending Data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textFormFieldVariables = [
      (
        "Location Name:",
        requireNonEmptyString,
        _locationNameCtl,
        "Enter the location name",
      ),
      (
        "Location Coordinates:",
        requireNonEmptyString,
        _locationCoordsCtl,
        "Enter the location coordinates",
      ),
      (
        // Change this from text input to selecting stars
        "Location Rating:",
        (input) => requireNumber(input, singleDigit: true),
        _locationRatingCtl,
        "Enter the location rating out of five",
      ),
      (
        "Reason For Rating:",
        requireNonEmptyString,
        _locationRatingReasonCtl,
        "Justify your rating",
      ),
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: responsiveWidth(context, 700),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 30,
          children: <Widget>[
            ...textFormFieldVariables.map((formFieldVariables) {
              return Column(
                children: [
                  Row(children: [FormText(context, formFieldVariables.$1)]),
                  TextFormField(
                    validator: formFieldVariables.$2,
                    controller: formFieldVariables.$3,
                    decoration: InputDecoration(
                      hintText: formFieldVariables.$4,
                      hintStyle: TextStyle(
                        fontSize: responsiveFontSize(context, 20),
                      ),
                    ),
                  ),
                ],
              );
            }),
            ElevatedButton(onPressed: submitForm, child: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}

class FormText extends StatelessWidget {
  const FormText(this.context, this.text, {super.key});

  final BuildContext context;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: darkGreen,
        fontSize: responsiveFontSize(context, 30),
      ),
    );
  }
}
