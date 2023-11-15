import 'package:muonroi/features/accounts/data/services/api.account.service.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signin.dart';
import 'package:muonroi/features/user/presentation/widgets/widget.validate.otp.dart';

class AccountRepository {
  final String username;
  final String password;
  final String userGuid;
  final _provider = AccountsService();

  AccountRepository(this.username, this.password, this.userGuid);

  Future<AccountSignInModel> signIn() => _provider.signIn(username, password);
  Future<bool> forgotPassword() => _provider.forgotPassword(username);
  Future<bool> logout() => _provider.logout(userGuid);
  Future<ModelValidateOtp> validOtp(String otp) =>
      _provider.validateOtp(otp, username);
  Future<bool> changePassword(
          String password, String newPassword, String otp, String token) =>
      _provider.changePassword(username, password, newPassword, otp, token);
}

class NetworkError extends Error {}
