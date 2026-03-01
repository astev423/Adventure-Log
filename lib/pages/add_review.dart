import 'package:adventure_log/constants.dart';
import 'package:adventure_log/utils.dart';
import 'package:flutter/material.dart';

class AddReview extends StatelessWidget {
  const AddReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/'),
            child: const Text("Go back to home"),
          ),
          AddReviewForm(),
        ],
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
  // Create a global key that uniquely identifies the Form widget and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  var _locationCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: requireNonEmptyString,
            controller: _locationCtl,
            decoration: InputDecoration(hintText: "Enter the location name"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
              print(_locationCtl.text);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
