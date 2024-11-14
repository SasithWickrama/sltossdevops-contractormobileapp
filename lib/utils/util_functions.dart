import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:image/image.dart' as ui;

import '../models/genaral_responce.dart';
import 'constants/asset_constants.dart';

class UtilFunction {
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  static String getDuration(int x) {
    Duration duration = Duration(seconds: x);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inDays)} $twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  static Future<void> openMap(String lat, String lng, String mapTitle) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(double.parse(lat), double.parse(lng)),
      title: mapTitle,
    );
  }

  static void callNumber(String number) {
    if (number.length == 10) {
      Uri tp = Uri(scheme: "tel", path: number);
      launchUrl(tp);
    }
  }

  static Future<void> scan(TextEditingController x, String type) async {
    String tempSN = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", false, ScanMode.DEFAULT);
    x.text = tempSN == '-1' ? '' : tempSN;
  }

  static Future<GenaralResponce> pickImage(BuildContext context, String lon,
      String lat, String name, String loc, String soid) async {
    try {
      ImageSource source;
      if (loc == AssetConstants.gallery) {
        source = ImageSource.gallery;
      } else {
        source = ImageSource.camera;
      }

      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return GenaralResponce(
            error: true, data: null, message: 'No Image Selected');
      }
      final imageTemp = File(image.path);

      var bytes = utf8.encode(
          "${DateTime.now().millisecondsSinceEpoch}${AssetConstants.secret}");
      var digest = sha1.convert(bytes);

      ui.Image? originalImage = ui.decodeImage(imageTemp.readAsBytesSync());
      ui.drawString(
          originalImage!,
          font: ui.arial48,
          y: 50,
          x: 50,
          "$soid#$name#${DateFormat.yMd().add_jm().format(DateTime.now())}#$lat,$lon#${digest.toString()}");
      var encodeImage = ui.encodeJpg(originalImage, quality: 100);

      var finalImage = File(imageTemp.path)..writeAsBytesSync(encodeImage);

      final compressedFile = await compressFile(finalImage);
      return GenaralResponce(
          error: false, data: compressedFile!.path, message: 'Success');
    } on PlatformException catch (e) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: 'Failed to pick image: $e',
      );
      return GenaralResponce(
          error: true, data: null, message: 'Failed to pick image: $e');
    }
  }

  static Future<File?> compressFile(File file) async {
    final filePath = file.absolute.path;

    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 50,
    );
    // print('*******************************************************');
    // print(file.lengthSync());
    // print(result!.lengthSync());

    return result;
  }

  // static bool validateONT(String sn) {
  //   if (sn.startsWith('4857', 0)) {
  //     return true;
  //   }
  //
  //   if (sn.startsWith('ZTE', 0)) {
  //     return true;
  //   }
  //
  //   if (sn.startsWith('ALCL', 0)) {
  //     return true;
  //   }
  //   return false;
  // }
  //
  // static bool validateSTB(String mac) {
  //   if (mac.startsWith('000430', 0)) {
  //     return true;
  //   }
  //
  //   if (mac.startsWith('0CF0B4', 0)) {
  //     return true;
  //   }
  //
  //   if (mac.startsWith('980637', 0)) {
  //     return true;
  //   }
  //
  //   if (mac.startsWith('FCD5D9', 0)) {
  //     return true;
  //   }
  //
  //   return false;
  // }


  static bool validateONT(String sn, List snValid){
    for (var x in snValid) {
      if(x.contains("ONT")){
        if(sn.startsWith(x.replaceAll("ONT_", '').trim(), 0)){
          return true;
        }
      }
    }
    return false;
  }

  static bool validateSTB(String sn, List snValid){
    for (var x in snValid) {
      if(x.contains("STB")){
        if(sn.startsWith(x.replaceAll("STB_", '').trim(), 0)){
          return true;
        }
      }
    }
    return false;
  }

  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }
}
