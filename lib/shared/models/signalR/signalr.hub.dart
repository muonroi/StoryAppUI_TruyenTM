import 'package:muonroi/core/Authorization/enums/key.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/http_connection_options.dart';

class SignalrCentral {
  static final httpConnectionOptions = HttpConnectionOptions(
    accessTokenFactory: () async {
      var sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences.getString(KeyToken.accessToken.name)!;
    },
  );
}
