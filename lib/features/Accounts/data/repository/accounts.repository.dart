import 'package:muonroi/features/accounts/data/services/api.account.service.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signin.dart';

class AccountRepository {
  final String username;
  final String password;
  final _provider = AccountsService();

  AccountRepository(this.username, this.password);

  Future<AccountSignInModel> signIn() => _provider.signIn(username, password);
  Future<bool> forgotPassword() => _provider.forgotPassword(username);
}

class NetworkError extends Error {}
