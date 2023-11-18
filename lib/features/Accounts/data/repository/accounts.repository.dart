import 'package:firebase_auth/firebase_auth.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signup.dart';
import 'package:muonroi/features/accounts/data/services/api.account.service.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/user/presentation/widgets/widget.validate.otp.dart';

class AccountRepository {
  final _provider = AccountsService();

  AccountRepository();

  Future<AccountSignInModel> signIn(
          String username, String password, String? uid) =>
      _provider.signIn(username, password, uid);

  Future<AccountSignInModel> register(AccountSignUpDTO request) =>
      _provider.registerUser(request);

  Future<bool> forgotPassword(
    String username,
  ) =>
      _provider.forgotPassword(username);

  Future<bool> logout(String userGuid) => _provider.logout(userGuid);

  Future<ModelValidateOtp> validOtp(
    String otp,
    String username,
  ) =>
      _provider.validateOtp(otp, username);

  Future<bool> changePassword(
    String username,
    String password,
    String newPassword,
    String otp,
    String token,
  ) =>
      _provider.changePassword(username, password, newPassword, otp, token);

  Future<String> getCurrentLocation() => _provider.getCurrentAddress();

  Future<User?> authGoogle() => _provider.signInWithGoogle();

  Future<bool> deleteAccount() => _provider.deleteUser();
}

class NetworkError extends Error {}
