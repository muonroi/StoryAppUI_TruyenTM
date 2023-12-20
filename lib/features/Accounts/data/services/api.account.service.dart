import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:muonroi/core/authorization/setting.api.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signup.dart';
import 'package:muonroi/features/accounts/settings/enum/enum.platform.dart';
import 'package:muonroi/features/user/presentation/widgets/widget.validate.otp.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class AccountsService {
  Future<AccountSignInModel> signIn(
      String username, String password, String? uid) async {
    try {
      Map<String, dynamic> data = {
        'username': username,
        'password': password,
        "uid": uid
      };
      Dio dio = Dio(BaseOptions(
          baseUrl: ApiNetwork.baseApi, responseType: ResponseType.plain));
      final response = await dio.post(ApiNetwork.login, data: data);
      if (response.statusCode == 200) {
        return accountSignInFromJson(response.data.toString());
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return AccountSignInModel(
            result: null, errorMessages: [], isOk: false, statusCode: 400);
      }
    }
    return AccountSignInModel(
        result: null, errorMessages: [], isOk: false, statusCode: 400);
  }

  Future<bool> forgotPassword(String username) async {
    try {
      Map<String, dynamic> data = {
        'username': username,
      };
      Dio dio = Dio(BaseOptions(
          baseUrl: ApiNetwork.baseApi, responseType: ResponseType.plain));
      final response = await dio.post(ApiNetwork.forgotPassword, data: data);
      if (response.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return false;
      }
    }
    return false;
  }

  Future<bool> logout(String userGuid) async {
    try {
      Map<String, dynamic> data = {"isUpdateAccountStatus": true};
      var baseUrl = await endPoint();
      final response = await baseUrl.post(ApiNetwork.logout, data: data);
      if (response.statusCode == 200) {
        var method = userBox.get("MethodLogin");
        if (method == EnumPlatform.google.name) {
          await signOutGoogle();
        }
        return true;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return false;
      }
    }
    return false;
  }

  Future<ModelValidateOtp> validateOtp(String otp, String username) async {
    try {
      Map<String, dynamic> data = {"username": username, "otpCode": otp};
      Dio dio = Dio(BaseOptions(
          baseUrl: ApiNetwork.baseApi, responseType: ResponseType.plain));
      final response = await dio.post(ApiNetwork.validateOtp, data: data);
      if (response.statusCode == 200) {
        return modelValidateOtpFromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw Exception("Failed to load otp token");
      }
    }
    throw Exception("Failed to load otp token");
  }

  Future<bool> changePassword(String username, String password,
      String confirmPassword, String otp, String token) async {
    try {
      Map<String, dynamic> data = {
        "isForgot": true,
        "username": username,
        "newPassword": password,
        "confirmPassword": confirmPassword,
        "otp": otp,
      };
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      Dio dio = Dio(BaseOptions(
          baseUrl: ApiNetwork.baseApi,
          headers: headers,
          responseType: ResponseType.plain));
      final response = await dio.patch(ApiNetwork.changePassword, data: data);
      if (response.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return false;
      }
    }
    return false;
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await auth.signInWithCredential(credential);
      final User? user = authResult.user;
      return user;
    } catch (error) {
      return null;
    }
  }

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<AccountSignInModel> registerUser(AccountSignUpDTO input) async {
    try {
      Map<String, dynamic> data = {
        "avatar": input.avatar,
        "name": input.name,
        "surname": input.surname,
        "username": input.username,
        "phoneNumber": input.phoneNumber,
        "email": input.email,
        "address": input.address,
        "birthDate": DateFormat("dd/MM/yyyy")
            .parse("01/01/2000")
            .toUtc()
            .toIso8601String(),
        "gender": input.gender,
        "uid": input.uid,
        "isSignInThirdParty": input.isSignInThirdParty,
        "platform": input.platform,
        "passwordHash": input.passwordHash
      };
      Dio dio = Dio(BaseOptions(
          baseUrl: ApiNetwork.baseApi, responseType: ResponseType.plain));
      final response = await dio.post(ApiNetwork.curdUser, data: data);
      if (response.statusCode == 200) {
        return accountSignInFromJson(response.data.toString());
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return AccountSignInModel(
            result: null, errorMessages: [], isOk: false, statusCode: 400);
      }
    }
    return AccountSignInModel(
        result: null, errorMessages: [], isOk: false, statusCode: 400);
  }

  Future<bool> deleteUser() async {
    try {
      Dio dio = await endPoint();
      final response = await dio.delete(ApiNetwork.curdUser, data: {});
      if (response.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return false;
      }
    }
    return false;
  }
}
