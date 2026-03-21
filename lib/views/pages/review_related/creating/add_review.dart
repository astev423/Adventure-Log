import "package:adventure_log/controllers/auth/utils.dart";
import "package:adventure_log/controllers/utils/constants.dart";
import "package:adventure_log/controllers/utils/helpers.dart";
import "package:adventure_log/controllers/utils/responsiveness.dart";
import "package:adventure_log/controllers/utils/validators.dart";
import "package:adventure_log/data/cloud_storage_funcs.dart";
import "package:adventure_log/data/models/review_info.dart";
import "package:adventure_log/data/review_queries.dart";
import "package:adventure_log/data/user_queries.dart";
import "package:adventure_log/views/widgets/upload_image.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:geolocator/geolocator.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";

class AddReview extends StatelessWidget {
  const AddReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: Center(
        child: Column(
          children: [
            headerText("Add a review", context),
            const _AddReviewForm(),
          ],
        ),
      ),
    );
  }
}

class _AddReviewForm extends StatefulWidget {
  const _AddReviewForm();

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
  bool _isReviewPublic = true;
  int _locationRating = 0;
  PlatformFile? _selectedFile;

  @override
  Widget build(BuildContext context) {
    final formFields = _getFormFields();

    return Container(
      height: responsiveHeight(context, 550),
      width: responsiveWidth(context, 800),
      padding: const EdgeInsets.all(15),
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
      _LocationCoordsField(
        context: context,
        locationCoordsCtl: _locationCoordsCtl,
      ),
      _locationImageText(),
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
      _MakeReviewPrivateOption((boxValue) => _isReviewPublic = boxValue!),
      appThemedButton(_submitForm, "Submit"),
    ];
  }

  Center _locationImageText() {
    return Center(
      child: Text(
        "Location Image (optional):",
        style: TextStyle(
          color: darkGreen,
          fontWeight: .w600,
          fontSize: responsiveFontSize(context, 15),
        ),
      ),
    );
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

    final imageURL = _selectedFile != null
        ? await uploadImageAndGetUrl(_selectedFile!)
        : null;
    final user = await getCurUserData();
    ReviewInfo review = ReviewInfo(
      getCurUserAuth().displayName!,
      _locationNameCtl.text,
      _locationCoordsCtl.text,
      _locationRating,
      _isReviewPublic,
      Timestamp.now(),
      reasonForRating: _locationRatingReasonCtl.text,
      imageURL: imageURL,
      profilePictureURL: user.profilePictureURL,
    );
    addReview(review);

    _formKey.currentState!.reset();
    setState(() {
      _locationRating = 0;
    });

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

class _MakeReviewPrivateOption extends StatelessWidget {
  final bool _isReviewPublic = true;
  final ValueChanged<bool?> _onBoxClicked;

  const _MakeReviewPrivateOption(this._onBoxClicked);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text("Make review public?", style: _formBoldText(context)),
        Checkbox(
          checkColor: Colors.white,
          fillColor: WidgetStateProperty.resolveWith<Color>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return darkGreen;
            }
            return Colors.transparent;
          }),
          value: _isReviewPublic,
          onChanged: _onBoxClicked,
        ),
      ],
    );
  }
}

class _LocationCoordsField extends StatelessWidget {
  final BuildContext context;
  final TextEditingController locationCoordsCtl;

  const _LocationCoordsField({
    required this.context,
    required this.locationCoordsCtl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Location Coordinates", style: _formBoldText(context)),
        appThemedButton(() async {
          try {
            final curLocation = await Geolocator.getCurrentPosition();
            locationCoordsCtl.text = getCoordsStrFromPos(curLocation);
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
          controller: locationCoordsCtl,
          decoration: InputDecoration(
            hintText: "Enter the location coordinates",
            hintStyle: TextStyle(fontSize: responsiveFontSize(context, 15)),
          ),
        ),
      ],
    );
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
                size: responsiveWidth(context, 22),
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
            hintStyle: TextStyle(fontSize: responsiveFontSize(context, 15)),
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
    fontSize: responsiveFontSize(context, 15),
  );
}
