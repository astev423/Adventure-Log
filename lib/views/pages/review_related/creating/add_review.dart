import "package:adventure_log/controllers/utils/helpers.dart";
import "package:adventure_log/data/cloud_storage_funcs.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:geolocator/geolocator.dart";
import "../../../../controllers/utils/constants.dart";
import "../../../../controllers/utils/responsiveness.dart";
import "../../../../controllers/utils/validators.dart";
import "../../../../data/firestore_queries.dart";
import "../../../../data/models/review_info.dart";
import "../../../widgets/upload_image.dart";
import "package:file_picker/file_picker.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

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

  @override
  Widget build(BuildContext context) {
    final formFields = _getFormFields();

    return Column(
      spacing: 20,
      children: [
        headerText("Add a review", context),
        Container(
          height: responsiveHeight(context, 560),
          width: responsiveWidth(context, 800),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: mint,
          ),
          child: Form(
            key: _formKey,
            child: ListView.separated(
              itemCount: formFields.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) => formFields[index],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _getFormFields() {
    return [
      _ReviewTextFormField(
        "Location Name:",
        requireNonEmptyString,
        _locationNameCtl,
        "Enter the location name",
      ),
      Column(
        children: [
          Text("Location Coordinates", style: _formBoldText(context)),
          appThemedButton(() async {
            try {
              final curLocation = await Geolocator.getCurrentPosition();
              _locationCoordsCtl.text = getCoordsStrFromPos(curLocation);
            } catch (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("You must enable location services!"),
                  duration: Duration(seconds: 5),
                ),
              );
            }
          }, "Use my current location (need location services enabled)"),
          TextFormField(
            validator: requireCoordsWithSixDecimals,
            controller: _locationCoordsCtl,
            decoration: InputDecoration(
              hintText: "Enter the location coordinates",
              hintStyle: TextStyle(fontSize: responsiveFontSize(context, 20)),
            ),
          ),
        ],
      ),
      Center(
        child: Text(
          "Location Image (optional):",
          style: TextStyle(
            color: darkGreen,
            fontWeight: .w600,
            fontSize: responsiveFontSize(context, 20),
          ),
        ),
      ),
      UploadImage(_onFileAttached),
      _StarRatingInteraction(
        rating: _locationRating,
        onChanged: (newRating) {
          setState(() {
            _locationRating = newRating;
          });
        },
      ),
      _ReviewTextFormField(
        "Reason For Rating (optional):",
        null,
        _locationRatingReasonCtl,
        "Justify your rating",
      ),
      appThemedButton(_submitForm, "Submit"),
    ];
  }

  void _onFileAttached(PlatformFile file) {
    setState(() {
      _selectedFile = file;
    });
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String? imageURL = _selectedFile != null
        ? await uploadImageAndGetUrl(_selectedFile!)
        : null;
    ReviewInfo review = ReviewInfo(
      FirebaseAuth.instance.currentUser!.displayName!,
      _locationNameCtl.text,
      _locationCoordsCtl.text,
      _locationRating,
      Timestamp.now(),
      reasonForRating: _locationRatingReasonCtl.text,
      imageURL: imageURL,
    );
    addReview(review);

    _formKey.currentState!.reset();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your review was successfully submitted!"),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}

class _StarRatingInteraction extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onChanged;

  const _StarRatingInteraction({required this.rating, required this.onChanged});

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
  return TextStyle(
    color: darkGreen,
    fontWeight: .w600,
    fontSize: responsiveFontSize(context, 20),
  );
}
