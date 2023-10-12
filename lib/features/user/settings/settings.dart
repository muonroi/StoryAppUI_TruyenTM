bool isEmailValid(String email) {
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regex.hasMatch(email);
}

bool isPhoneNumberValid(String phone) {
  RegExp regex = RegExp(
      r'^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');
  return regex.hasMatch(phone);
}

Set<String> formatNameUser(String fullName) {
  var regex = RegExp(r"(.+)(?:\s(\w+))$");
  var match = regex.firstMatch(fullName);
  var result = <String>{};
  if (match != null) {
    String? firstName =
        match.group(1) != null ? match.group(1)!.trim() : match.group(1);
    String? lastName =
        match.group(2) != null ? match.group(2)!.trim() : match.group(2);
    result.addAll({firstName ?? '', lastName ?? ''});
    return result;
  }
  return result;
}
