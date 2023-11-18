class AccountInfo {
  String userGuid;
  String fullName;
  String username;
  String email;
  String phoneNumber;
  DateTime birthDate;
  String avatar;
  int? totalStoriesBought;
  double? coin;
  AccountInfo(
      {required this.userGuid,
      required this.fullName,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.birthDate,
      required this.avatar,
      this.totalStoriesBought,
      this.coin});
}
