import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';

import '../models/genaral_responce.dart';
import '../utils/constants/asset_constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AppRequest {
  Future<GenaralResponce> sendRequest(String function, var inputlist) async {
    Uri url = Uri(
      scheme: AssetConstants.apiScheema1,
      host: AssetConstants.apihost1,
      path: '${AssetConstants.apipath1}$function',
    );
    GenaralResponce newResponce;
    Logger().i(function);
    Logger().i(inputlist);
    try {
      final response = await http.post(url,
          headers: {"HttpHeaders.contentTypeHeader": "application/json"},
          body: inputlist);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        //Logger().i(responseData);
        newResponce = GenaralResponce(
            error: responseData['error'],
            message: responseData['message'],
            data: responseData['data']);
      } else {
        newResponce = GenaralResponce(
            error: true, message: 'API Error Code:${response.statusCode} ');
      }
    } catch (e) {
      newResponce = GenaralResponce(
          error: true, message: 'Connection Error Code:${e.toString()} ');
    }

    return newResponce;
  }

  Future<GenaralResponce> uploadImage(
      String location, String desc, var imageFile, String rtom) async {
    Uri url = Uri(
      scheme: AssetConstants.apiScheema1,
      host: AssetConstants.apihost1,
      path: AssetConstants.apiimage1,
    );
    GenaralResponce newResponce =
        GenaralResponce(error: true, message: 'Function error');
    Logger().d(url);
    try {
      var request = http.MultipartRequest("POST", url);
      request.fields['location'] = location;
      request.fields['desc'] = desc;
      request.fields['rtom'] = rtom;
      request.files.add(http.MultipartFile.fromBytes(
          'image', await File(imageFile).readAsBytes(),
          filename: 'test.jpg', contentType: MediaType('image', 'jpeg')));

      await request.send().then((response) async {
        Logger().d('uploadImage');
        Logger().d(response.statusCode.toString());

        if (response.statusCode == 200) {
          var responseData = json.decode(await response.stream.bytesToString());
          Logger().d(responseData);
          newResponce = GenaralResponce(
              error: responseData['error'], message: responseData['message']);
        } else {
          newResponce = GenaralResponce(
              error: true,
              message: 'API Error Code:${response.statusCode.toString()} ');
        }
      });
    } catch (e) {
      newResponce = GenaralResponce(
          error: true, message: 'Connection Error Code:${e.toString()} ');
    }
    return newResponce;
  }
}
