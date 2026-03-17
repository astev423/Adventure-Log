import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:adventure_log/controllers/utils/responsiveness.dart';
import 'package:adventure_log/controllers/utils/validators.dart';
import 'package:adventure_log/data/firestore_queries.dart';
import 'package:adventure_log/data/models/review_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddReview extends StatelessWidget {
  const AddReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: Center(child: AddReviewForm()),
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
  final _locationRatingReasonCtl = TextEditingController();
  int _locationRating = 0;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      ReviewInfo review = ReviewInfo(
        FirebaseAuth.instance.currentUser!.displayName!,
        _locationNameCtl.text,
        _locationCoordsCtl.text,
        _locationRating,
        reasonForRating: _locationRatingReasonCtl.text,
      );
      addReview(review);
      setState(() {
        _locationCoordsCtl.text = "";
        _locationNameCtl.text = "";
        _locationRating = 0;
        _locationRatingReasonCtl.text = "";
      });
      const snackBar = SnackBar(
        content: Text('Your review was successfully submitted!'),
        duration: Duration(seconds: 5),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsiveHeight(context, 1300),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: responsiveWidth(context, 900),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            ReviewTextFormField(
              "Location Name:",
              requireNonEmptyString,
              _locationNameCtl,
              "Enter the location name",
            ),
            responsiveBox(context, 6),
            ReviewTextFormField(
              "Location Coordinates:",
              requireNonEmptyString,
              _locationCoordsCtl,
              "Enter the location coordinates",
            ),
            responsiveBox(context, 6),
            ...imagePicker(context),
            responsiveBox(context, 6),
            StarRating(
              rating: _locationRating,
              onChanged: (newRating) {
                setState(() {
                  _locationRating = newRating;
                });
              },
            ),
            responsiveBox(context, 6),
            ReviewTextFormField(
              "Reason For Rating:",
              null,
              _locationRatingReasonCtl,
              "Justify your rating",
            ),
            responsiveBox(context, 6),
            ElevatedButton(onPressed: _submitForm, child: const Text('Submit')),
          ],
        ),
      ),
    );
  }

  List<Widget> imagePicker(BuildContext context) {
    return [
      Center(child: Text("Location Image:", style: formBoldText(context))),
      PickFileButton(),
    ];
  }
}

class StarRating extends StatelessWidget {
  final int rating;
  // We need callback here but not for the text forms as the controller is shared and updates
  // parents controller.text aswell on change
  final ValueChanged<int> onChanged;

  const StarRating({super.key, required this.rating, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Location Rating:", style: formBoldText(context)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            final starNumber = index + 1;
            return IconButton(
              onPressed: () => onChanged(starNumber),
              icon: Icon(
                starNumber <= rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: responsiveWidth(context, 32),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class ReviewTextFormField extends StatelessWidget {
  final String _locationName;
  final String? Function(String?)? _validator;
  final TextEditingController _controller;
  final String _hintText;

  const ReviewTextFormField(
    this._locationName,
    this._validator,
    this._controller,
    this._hintText, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_locationName, style: formBoldText(context)),
        TextFormField(
          validator: _validator,
          controller: _controller,
          decoration: InputDecoration(
            hintText: _hintText,
            hintStyle: TextStyle(fontSize: responsiveFontSize(context, 20)),
          ),
        ),
      ],
    );
  }
}

class PickFileButton extends StatefulWidget {
  const PickFileButton({super.key});

  @override
  State<PickFileButton> createState() => _PickFileButtonState();
}

class _PickFileButtonState extends State<PickFileButton> {
  PlatformFile? _selectedFile;

  Future<void> _pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) {
      return;
    }

    setState(() {
      _selectedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: _pickFile, child: const Text('Pick a file')),
        if (_selectedFile != null) ...[
          const SizedBox(height: 12),
          Text('Selected: ${_selectedFile!.name}'),
        ],
      ],
    );
  }
}

TextStyle formBoldText(BuildContext context) {
  return TextStyle(color: darkGreen, fontSize: responsiveFontSize(context, 30));
}
