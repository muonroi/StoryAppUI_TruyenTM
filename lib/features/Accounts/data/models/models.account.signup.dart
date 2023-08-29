class AccountInfo {
  String? fullName;
  String? username;
  String? password;
  String? email;
  String? phoneNumber;
  bool? gender;
  DateTime? birthDate;
  String? imageLink;
  int? totalStoriesBought;
  double? coin;
  AccountInfo(
      {this.fullName,
      this.username,
      this.password,
      this.email,
      this.phoneNumber,
      this.gender,
      this.birthDate,
      this.imageLink,
      this.totalStoriesBought,
      this.coin});
}
