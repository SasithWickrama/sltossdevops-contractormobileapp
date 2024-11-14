import '../models/genaral_responce.dart';
import '../network/app_request.dart';

class LocationController {
  Future<GenaralResponce> updateCusLocxx(
      String soid, String lon, String lat) async {
    return await AppRequest()
        .sendRequest('updateCusLoc', {'soid': soid, 'lon': lon, 'lat': lat});
  }

  Future<GenaralResponce> updateUserLoc(
      String uid, String lat, String lon) async {
    return await AppRequest()
        .sendRequest('updateUserLoc', {'uid': uid, 'lat': lat, 'lon': lon});
  }
}
