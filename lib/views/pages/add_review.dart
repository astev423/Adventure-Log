import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:adventure_log/controllers/utils/responsiveness.dart';
import 'package:adventure_log/controllers/utils/validators.dart';
import 'package:adventure_log/data/firestore_queries.dart';
import 'package:adventure_log/data/models/review_info.dart';
import 'package:adventure_log/views/widgets/upload_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddReview extends StatelessWidget {
  const AddReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: Center(child: _AddReviewForm()),
    );
  }
}

class _AddReviewForm extends StatefulWidget {
  @override
  State<_AddReviewForm> createState() {
    return _AddReviewFormState();
  }
}

class _AddReviewFormState extends State<_AddReviewForm> {
  final _formKey = GlobalKey<FormState>();

  final _locationNameCtl = TextEditingController();
  final _locationCoordsCtl = TextEditingController();
  final _locationRatingReasonCtl = TextEditingController();
  int _locationRating = 0;
  PlatformFile? _selectedFile;

  void _onFileAttached(PlatformFile file) {
    setState(() {
      _selectedFile = file;
    });
  }

  Future<String> _uploadImageAndGetUrl(PlatformFile file) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
    final ref = FirebaseStorage.instance.ref().child(fileName);
    final metadata = SettableMetadata(
      contentType: 'image/${file.extension ?? 'jpeg'}',
    );

    await ref.putData(file.bytes!, metadata);

    final url = await ref.getDownloadURL();
    return url;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String? imageURL = _selectedFile != null
          ? await _uploadImageAndGetUrl(_selectedFile!)
          : null;
      ReviewInfo review = ReviewInfo(
        FirebaseAuth.instance.currentUser!.displayName!,
        _locationNameCtl.text,
        _locationCoordsCtl.text,
        _locationRating,
        reasonForRating: _locationRatingReasonCtl.text,
        imageURL: imageURL,
      );
      addReview(review);

      _formKey.currentState!.reset();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Your review was successfully submitted!'),
            duration: Duration(seconds: 5),
          ),
        );
      }
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
            _ReviewTextFormField(
              "Location Name:",
              requireNonEmptyString,
              _locationNameCtl,
              "Enter the location name",
            ),
            responsiveBox(context, 6),

            _ReviewTextFormField(
              "Location Coordinates:",
              requireCoordsWithSixDecimals,
              _locationCoordsCtl,
              "Enter the location coordinates",
            ),
            responsiveBox(context, 6),

            UploadImage(_onFileAttached),

            responsiveBox(context, 6),

            _StarRating(
              rating: _locationRating,
              onChanged: (newRating) {
                setState(() {
                  _locationRating = newRating;
                });
              },
            ),

            responsiveBox(context, 6),

            _ReviewTextFormField(
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
}

class _StarRating extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onChanged;

  const _StarRating({required this.rating, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Location Rating:", style: _formBoldText(context)),
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

class _ReviewTextFormField extends StatelessWidget {
  final String _locationName;
  final String? Function(String?)? _validator;
  final TextEditingController _controller;
  final String _hintText;

  const _ReviewTextFormField(
    this._locationName,
    this._validator,
    this._controller,
    this._hintText,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_locationName, style: _formBoldText(context)),
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

TextStyle _formBoldText(BuildContext context) {
  return TextStyle(color: darkGreen, fontSize: responsiveFontSize(context, 30));
}
