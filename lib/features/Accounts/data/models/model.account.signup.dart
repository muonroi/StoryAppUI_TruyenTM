class AccountSignUpDTO {
  String name;
  String surname;
  String username;
  String phoneNumber;
  String email;
  String address;
  int gender;
  String uid;
  bool isSignInThirdParty;
  int platform;
  String passwordHash;
  String avatar;

  AccountSignUpDTO(
      {required this.name,
      required this.surname,
      required this.username,
      required this.phoneNumber,
      required this.email,
      required this.address,
      required this.gender,
      required this.uid,
      required this.isSignInThirdParty,
      required this.platform,
      required this.passwordHash,
      required this.avatar});
}
