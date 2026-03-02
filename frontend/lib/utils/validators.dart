String? requireNonEmptyString(String? v) {
  if (v == null || v.trim().isEmpty) {
    return 'Text required here';
  }

  return null;
}

String? requireNumber(String? v, {bool singleDigit = false}) {
  if (v == null || v.trim().isEmpty) {
    return 'Input required';
  }

  var inputAsNum = num.tryParse(v);
  if (inputAsNum == null) {
    return 'Must enter a valid number';
  }

  if (singleDigit && (inputAsNum < 0 || inputAsNum > 9)) {
    return 'Only enter one positive digit';
  }

  return null;
}
