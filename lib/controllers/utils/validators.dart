String? requireNonEmptyString(String? v) {
  if (v == null || v.trim().isEmpty) {
    return 'Text required here';
  }

  return null;
}

String? requireIntFrom1To5(String? v, {bool singleDigit = false}) {
  if (v == null || v.trim().isEmpty) {
    return 'Input required';
  }

  var inputAsNum = int.tryParse(v);
  if (inputAsNum == null) {
    return 'Must enter a valid integer';
  }

  if (singleDigit && (inputAsNum < 1 || inputAsNum > 5)) {
    return 'Only enter one positive digit between 1 and 5';
  }

  return null;
}
