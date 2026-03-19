String? requireNonEmptyString(String? v) {
  if (v == null || v.trim().isEmpty) {
    return "Text required here";
  }

  return null;
}

String? requireIntFrom1To5(String? v, {bool singleDigit = false}) {
  if (v == null || v.trim().isEmpty) {
    return "Input required";
  }

  var inputAsNum = int.tryParse(v);
  if (inputAsNum == null) {
    return "Must enter a valid integer";
  }

  if (singleDigit && (inputAsNum < 1 || inputAsNum > 5)) {
    return "Only enter one positive digit between 1 and 5";
  }

  return null;
}

String? requireCoordsWithSixDecimals(String? userInput) {
  if (userInput == null || userInput.trim().isEmpty) {
    return "Input required";
  }

  final input = userInput.trim();

  // Regex: start of word may optionally contain a "-" and must be followed by one or more numbers after
  // and ending with 6 digits after the decimal for needed precision, seperated by comma and 0 or more
  // spaces
  final sixDigitCoordsRegex = RegExp(r"^-?\d+\.\d{6},\s*-?\d+\.\d{6}$");

  if (!sixDigitCoordsRegex.hasMatch(input)) {
    return "Enter two coordinates with exactly 6 decimal places (e.g., 44.123456, -123.123456)";
  }

  return null;
}
