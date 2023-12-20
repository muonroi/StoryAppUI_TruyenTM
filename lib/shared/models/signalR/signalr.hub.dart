import 'package:muonroi/core/Authorization/enums/key.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:signalr_netcore/http_connection_options.dart';

class SignalrCentral {
  static final httpConnectionOptions = HttpConnectionOptions(
    accessTokenFactory: () async {
      return userBox.get(KeyToken.accessToken.name)!;
    },
  );
}
