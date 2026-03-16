import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:adventure_log/controllers/utils/responsiveness.dart';
import 'package:adventure_log/controllers/utils/validators.dart';
import 'package:adventure_log/data/firestore_queries.dart';
import 'package:adventure_log/data/models/review_info.dart';
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
  int _locationRating = 0;
  final _locationRatingReasonCtl = TextEditingController();
  String? _response;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      ReviewInfo review = ReviewInfo(
        _locationNameCtl.text,
        _locationCoordsCtl.text,
        _locationRating,
        _locationRatingReasonCtl.text,
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
              ReviewTextFormField(
                "Location Name:",
                requireNonEmptyString,
                _locationNameCtl,
                "Enter the location name",
              ),
              ReviewTextFormField(
                "Location Coordinates:",
                requireNonEmptyString,
                _locationCoordsCtl,
                "Enter the location coordinates",
              ),
              Center(
                child: Text(
                  "Location Image:",
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: responsiveFontSize(context, 30),
                  ),
                ),
              ),
              PickFileButton(),
              Column(
                children: [
                  Text(
                    "Location Rating:",
                    style: TextStyle(
                      color: darkGreen,
                      fontSize: responsiveFontSize(context, 30),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      final starNumber = index + 1;
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            _locationRating = starNumber;
                          });
                        },
                        icon: Icon(
                          starNumber <= _locationRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: responsiveWidth(context, 32),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              ReviewTextFormField(
                "Reason For Rating:",
                requireNonEmptyString,
                _locationRatingReasonCtl,
                "Justify your rating",
              ),
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

class ReviewTextFormField extends StatelessWidget {
  final String _locationName;
  final String? Function(String?) _validator;
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
        Text(
          _locationName,
          style: TextStyle(
            color: darkGreen,
            fontSize: responsiveFontSize(context, 30),
          ),
        ),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _pickFile,
            child: const Text('Pick a file'),
          ),
        ),
        if (_selectedFile != null) ...[
          const SizedBox(height: 12),
          Text('Selected: ${_selectedFile!.name}'),
        ],
      ],
    );
  }
}
