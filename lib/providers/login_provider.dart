import 'dart:convert';

import 'package:contractor_app/controllers/login_controller.dart';
import 'package:contractor_app/screens/home.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../utils/constants/asset_constants.dart';

class LoginProvider extends ChangeNotifier {
  final LoginController _authController = LoginController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _userNameController = TextEditingController();
  TextEditingController get userNameController => _userNameController;

  final _otpController = TextEditingController();
  TextEditingController get otpController => _otpController;

  bool _loginstatus = true;
  bool get loginstatus => _loginstatus;

  User _appUser = User(contractor: '', mobile: '', username: '');
  User get appUser => _appUser;
  set appUser(User x) => _appUser = x;

  Future<void> validateInput(BuildContext context) async {
    if (_loginstatus && _userNameController.text == '') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Username Cannot be Null",
      );
    } else if (!_loginstatus && _otpController.text == '') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "OTP Cannot be Null",
      );
    } else {
      await loginButtonClick(context);
    }
  }

  Future<void> loginButtonClick(BuildContext context) async {
    if (_loginstatus) {
      final SharedPreferences prefs = await _prefs;
      if (!prefs.containsKey('key')) {
        var bytes = utf8.encode(
            "${DateTime.now().millisecondsSinceEpoch}${AssetConstants.secret}");
        var digest = sha1.convert(bytes);
        // Logger().i(digest.toString());
        prefs.setString('key', digest.toString());
      }
      await _authController
          .getOTPRequest(
              _userNameController.text, prefs.getString('key').toString())
          .then(
        (value) {
          if (!value.getError()) {
            _loginstatus = false;
          } else {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: value.getMsg(),
            );
          }
        },
      );
    } else {
      await _authController
          .validateRequest(_userNameController.text, _otpController.text)
          .then(
        (value) async {
          if (!value.getError()) {
            _loginstatus = true;
            appUser = User(
                contractor: value.getData()[0]['CONTRACTOR'],
                mobile: value.getData()[0]['MOBILE'],
                username: value.getData()[0]['USERNAME']);

            //Map decode_options = jsonDecode(value.getData());
            String user = jsonEncode(User(
                contractor: value.getData()[0]['CONTRACTOR'],
                mobile: value.getData()[0]['MOBILE'],
                username: value.getData()[0]['USERNAME']));
            //jsonEncode(User.fromJson(decode_options));
            final SharedPreferences prefs = await _prefs;
            prefs.setString('user', user);

            //  _homeController.getNoList(appUser.username).then((value) => null);

            _userNameController.text = '';
            _otpController.text = '';
            _loginstatus = true;

            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: value.getMsg(),
            );
          }
        },
      );
    }
  }
}
