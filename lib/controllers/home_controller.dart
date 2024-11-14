import 'package:contractor_app/models/genaral_responce.dart';

import '../network/app_request.dart';

class HomeController {
  Future<GenaralResponce> getNoList(String username) async {
    return await AppRequest().sendRequest('getNoList', {'username': username});
  }

  Future<GenaralResponce> getSODetails(String soid) async {
    return await AppRequest().sendRequest('getSODetails', {'soid': soid});
  }

  Future<GenaralResponce> updateCancelledSo(
      String soid, String svtype, String linetype, String reason) async {
    return await AppRequest().sendRequest('updateCancelledSo', {
      'soid': soid,
      'svtype': svtype,
      'linetype': linetype,
      'reason': reason
    });
  }

  Future<GenaralResponce> updateSoStatus(String soid, String status) async {
    return await AppRequest()
        .sendRequest('updateSoStatus', {'soid': soid, 'status': status});
  }

  Future<GenaralResponce> updateSoPkg(String soid, String status) async {
    return await AppRequest()
        .sendRequest('updateSoPkg', {'soid': soid, 'status': status});
  }

  Future<GenaralResponce> insertSN(String soid, String type, String sn) async {
    return await AppRequest()
        .sendRequest('insertSN', {'soid': soid, 'type': type, 'sn': sn});
  }

  Future<GenaralResponce> getImgList(String soid) async {
    return await AppRequest().sendRequest('getImgList', {'soid': soid});
  }

  Future<GenaralResponce> updateImgCount(String imgname, String imgdisname,
      String soid, String lon, String lat) async {
    return await AppRequest().sendRequest('updateImg', {
      'soid': soid,
      'imgdisname': imgdisname,
      'lon': lon,
      'lat': lat,
      'imgname': imgname
    });
  }

  Future<GenaralResponce> uploadQualityImg(
      String location, String desc, var file,String rtom) async {
    return await AppRequest().uploadImage(location, desc, file,rtom);
  }

  Future<GenaralResponce> updateDropWire(
      String soid, String len, String voice) async {
    return await AppRequest().sendRequest(
        'insertDropWire', {'soid': soid, 'len': len, 'voice': voice});
  }

  Future<GenaralResponce> updatePoles(String soid, String pcount) async {
    return await AppRequest()
        .sendRequest('updatePoles', {'soid': soid, 'pcount': pcount});
  }

  Future<GenaralResponce> getReasonList() async {
    return await AppRequest().sendRequest('getReasonList', {});
  }

  Future<GenaralResponce> getSnValidationList() async {
    return await AppRequest().sendRequest('getSnValidationList', {});
  }

  Future<GenaralResponce> getSNList(String soid) async {
    return await AppRequest().sendRequest('getSNList', {'soid': soid});
  }

  Future<GenaralResponce> cancellMainSO(
      String soid, String reason, String com) async {
    return await AppRequest().sendRequest(
        'cancellMainSO', {'soid': soid, 'reason': reason, 'com': com});
  }

  Future<GenaralResponce> updateNewFdp(
      String soid, String fdp, String loop) async {
    return await AppRequest()
        .sendRequest('updateNewFdp', {'soid': soid, 'fdp': fdp, 'loop': loop});
  }

  Future<GenaralResponce> getNewFdp(String soid) async {
    return await AppRequest().sendRequest('getNewFdp', {'soid': soid});
  }

  Future<GenaralResponce> getFTTHMaterialList(String con) async {
    return await AppRequest().sendRequest('getFTTHMaterialList', {'con': con});
  }

  Future<GenaralResponce> getPoleList() async {
    return await AppRequest().sendRequest('getPoleList', {});
  }

  Future<GenaralResponce> insertMaterial(
      String soid, String len, String voice, String name, String sn) async {
    return await AppRequest().sendRequest('insertMaterial',
        {'soid': soid, 'len': len, 'voice': voice, 'name': name, 'sn': sn});
  }

  Future<GenaralResponce> getaddedMaterialList(String soid) async {
    return await AppRequest()
        .sendRequest('getaddedMaterialList', {'soid': soid});
  }

  Future<GenaralResponce> deleteMaterial(String metid) async {
    return await AppRequest().sendRequest('deleteMaterial', {'metid': metid});
  }

  Future<GenaralResponce> updateMaterial(
      String metid, String sn, String type) async {
    return await AppRequest().sendRequest(
        'updateMaterial', {'metid': metid, 'sn': sn, 'type': type});
  }

  Future<GenaralResponce> removePoleImgs(String soid) async {
    return await AppRequest().sendRequest('removePoleImgs', {'soid': soid});
  }

  Future<GenaralResponce> updateAttributes(
      String soid, String val, String user, String att) async {
    return await AppRequest().sendRequest('updateAttributes',
        {'soid': soid, 'val': val, 'user': user, 'attname': att});
  }

  Future<GenaralResponce> insertPoleImage(String soid, String pn) async {
    return await AppRequest()
        .sendRequest('insertPoleImage', {'soid': soid, 'pno': pn});
  }

  Future<GenaralResponce> getAttList(String soid) async {
    return await AppRequest().sendRequest('getFTTHAttList', {'soid': soid});
  }

  Future<GenaralResponce> getaddedAttlList(String soid) async {
    return await AppRequest().sendRequest('getaddedAttList', {'soid': soid});
  }

  Future<GenaralResponce> deleteAtt(String soid, String attname) async {
    return await AppRequest()
        .sendRequest('deleteAtt', {'soid': soid, 'attname': attname});
  }
}
