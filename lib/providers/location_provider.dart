import 'dart:async';
import 'dart:convert';

import 'package:contractor_app/controllers/home_controller.dart';
import 'package:contractor_app/controllers/location_controller.dart';
import 'package:contractor_app/controllers/login_controller.dart';
import 'package:contractor_app/providers/home_provider.dart';
import 'package:contractor_app/providers/login_provider.dart';
import 'package:contractor_app/utils/constants/pref_key.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../utils/constants/asset_constants.dart';

class LocationProvider extends ChangeNotifier {
  late LocationSettings locationSettings;
  late StreamSubscription<Position> positionStream;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Position? _position;
  Position? get position => _position;

  bool _isloading = false;
  bool get islooding => _isloading;

  void _setlocationSettings() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 180),
        //(Optional) Set foreground notification config to keep the app alive
        //when going to the background
        // foregroundNotificationConfig: const ForegroundNotificationConfig(
        //   notificationText:
        //       "Example app will continue to receive your location even when you aren't using it",
        //   notificationTitle: "Running in Background",
        //   enableWakeLock: true,
        // )
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }
  }

  Future<void> startLocationMonitor(BuildContext context) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("LocationServiceDisabledException");
      }
      _position = await _determinePosition();
      _setlocationSettings();
      positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position? position) async {
        final SharedPreferences prefs = await _prefs;
        Map userMap = jsonDecode(prefs.getString(PrefKey.user).toString());
        var user = User.fromJson(userMap);
        await _locController.updateUserLoc(user.username,
            position!.longitude.toString(), position.latitude.toString());
      });
    } catch (e) {
      Logger().e(e);
      if (e.toString().contains("LocationServiceDisabledException")) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          text: "Please enable location to continue with a smooth service",
        );
      }
    }
  }

  Future<bool> isLocationEnabled(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        text: "Please Enable Device Location to Continue.",
      );
    }
    return serviceEnabled;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  final LocationController _locController = LocationController();
  final HomeController _homeController = HomeController();

  void setLoder(bool x) {
    _isloading = x;
    notifyListeners();
  }

  Future<void> updateCusLoc(String soid, BuildContext context) async {
    EasyLoading.show();
    try {
      setLoder(true);
      _position = await _determinePosition();
      await _homeController.updateAttributes(
          soid,
          _position!.latitude.toString(),
          Provider.of<LoginProvider>(context, listen: false).appUser.username,
          AssetConstants.cusLocationlat);
      await _homeController.updateAttributes(
          soid,
          _position!.longitude.toString(),
          Provider.of<LoginProvider>(context, listen: false).appUser.username,
          AssetConstants.cusLocationlon);

      HomeProvider homeProvider =
          Provider.of<HomeProvider>(context, listen: false);
      homeProvider.att.att_cusLat = _position!.latitude.toString();
      homeProvider.att.att_cusLon = _position!.longitude.toString();
      EasyLoading.dismiss();

      notifyListeners();
      setLoder(false);
    } catch (e) {
      Logger().e(e);
      CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        text: "Please Enable Device Location to Continue.",
      );
      //setLoder(false);
      EasyLoading.dismiss();
    }
  }

  Future<Position?> returnLoc(BuildContext context) async {
    try {
      _position = await _determinePosition();
      return _position;
    } catch (e) {
      Logger().e(e);
      CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        text: "Please Enable Device Location to Continue.",
      );
      return null;
    }
  }
}
