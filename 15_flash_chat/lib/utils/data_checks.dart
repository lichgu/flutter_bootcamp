bool isEmail(String value) {
  String regex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(regex);
  return value.isNotEmpty && regExp.hasMatch(value);
}

bool isPassword(String value) {
  return value.length >= 6;
}

bool isUsername(String value) {
  return value.length >= 3;
}
