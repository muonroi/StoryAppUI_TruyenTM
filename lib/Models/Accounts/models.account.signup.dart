class SignUpDto {
  String? fullName;
  String? username;
  String? password;
  String? email;
  String? phoneNumber;
  bool? gender;
  DateTime? birthDate;
  SignUpDto(
      {this.fullName,
      this.username,
      this.password,
      this.email,
      this.phoneNumber,
      this.gender,
      this.birthDate});
}
