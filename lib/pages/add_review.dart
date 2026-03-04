import 'package:adventure_log/utils/constants.dart';
import 'package:adventure_log/utils/http_reqs.dart';
import 'package:adventure_log/utils/responsiveness.dart';
import 'package:adventure_log/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  String? _response;
  late final textFormFieldVariables = [
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

  List<Widget> _buildTextFormFields() {
    return textFormFieldVariables.map((formFieldVariables) {
      return Column(
        children: [
          FormText(formFieldVariables.$1),
          TextFormField(
            validator: formFieldVariables.$2,
            controller: formFieldVariables.$3,
            decoration: InputDecoration(
              hintText: formFieldVariables.$4,
              hintStyle: TextStyle(fontSize: responsiveFontSize(context, 20)),
            ),
          ),
        ],
      );
    }).toList();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var response = await fetchReviews();
      setState(() {
        _response = response.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: responsiveWidth(context, 700),
      child: Form(
        key: _formKey,
        child: SizedBox(
          height: responsiveHeight(context, 1000),
          child: ListView(
            children: [
              ..._buildTextFormFields(),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
              if (_response != null) Text(_response!),
            ],
          ),
        ),
      ),
    );
  }
}

class FormText extends StatelessWidget {
  final String text;

  const FormText(this.text, {super.key});

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
