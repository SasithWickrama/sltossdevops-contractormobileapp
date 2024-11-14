import 'package:contractor_app/models/genaral_responce.dart';
import '../network/app_request.dart';
import '../utils/constants/asset_constants.dart';

class LoginController {
  Future<GenaralResponce> getOTPRequest(
      String username, String deviceid) async {
    return await AppRequest().sendRequest('getCode', {
      'username': username,
      'appversion': AssetConstants.version,
      'deviceid': deviceid
    });
  }

  Future<GenaralResponce> validateRequest(String username, String otp) async {
    return await AppRequest().sendRequest('userLogin', {
      'username': username,
      'appversion': AssetConstants.version,
      'otp': otp
    });
  }
}
