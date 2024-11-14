import 'dart:convert';
import 'dart:io';

import 'package:contractor_app/models/attributes.dart';
import 'package:contractor_app/models/job.dart';
import 'package:contractor_app/models/number_list.dart';
import 'package:contractor_app/models/quality_image.dart';
import 'package:contractor_app/providers/attributeProvider.dart';
import 'package:contractor_app/providers/location_provider.dart';
import 'package:contractor_app/providers/login_provider.dart';
import 'package:contractor_app/providers/material_provider.dart';
import 'package:contractor_app/utils/constants/pref_key.dart';
import 'package:contractor_app/utils/util_functions.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/home_controller.dart';
import '../models/user.dart';
import '../screens/home.dart';
import '../utils/constants/asset_constants.dart';

class HomeProvider extends ChangeNotifier {
  late Job _newJob = new Job();
  Job get newJob => _newJob;
  set newJob(x) => _newJob = x;

  late Attributes _att = new Attributes();
  Attributes get att => _att;
  set att(x) => _att = x;

  User _appUser = User(contractor: '', mobile: '', username: '');
  User get appUser => _appUser;
  set appUser(User x) => _appUser = x;

  List<QulaityImage> _qualityImgList = [];
  List<QulaityImage> get qualityImgList => _qualityImgList;

  QulaityImage _selectedImage = QulaityImage();
  QulaityImage get selectedImage => _selectedImage;
  void set selectedImage(QulaityImage x) => _selectedImage = x;

  late List<String> uploadedimages;

  final HomeController _homeController = HomeController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // final Location location = Location();

  bool _fdpchanged = false;
  bool get fdpchanged => _fdpchanged;
  void set fdpchanged(bool x) => _fdpchanged = x;

  bool _primaryVoice = true;
  bool get primaryVoice => _primaryVoice;
  void set primaryVoice(bool x) => _primaryVoice = x;
  bool _primaryVoiceenabled = false;

  bool _secondaryVoice = true;
  bool get secondaryVoice => _secondaryVoice;
  bool _secondaryVoiceenabled = false;
  bool get secondaryVoiceenabled => _secondaryVoiceenabled;
  void set secondaryVoice(bool x) => _secondaryVoice = x;

  bool _bb = true;
  bool get bb => _bb;
  bool _bbenabled = false;
  bool get bbenabled => _bbenabled;
  set bb(bool x) => _bb = x;

  bool _iptv1 = true;
  bool get iptv1 => _iptv1;
  bool _iptv1enabled = false;
  bool get iptv1enabled => _iptv1enabled;
  set iptv1(bool x) => _iptv1 = x;

  bool _iptv2 = true;
  bool get iptv2 => _iptv2;
  bool _iptv2enabled = false;
  bool get iptv2enabled => _iptv2enabled;
  void set iptv2(bool x) => _iptv2 = x;

  bool _iptv3 = true;
  bool get iptv3 => _iptv3;
  bool _iptv3enabled = false;
  bool get iptv3enabled => _iptv3enabled;
  void set iptv3(bool x) => _iptv3 = x;

  final _voice1SnController = TextEditingController();
  TextEditingController get voice1SnController => _voice1SnController;

  final _voice2SnController = TextEditingController();
  TextEditingController get voice2SnController => _voice2SnController;

  final _ontSnController = TextEditingController();
  TextEditingController get ontSnController => _ontSnController;

  final _iptv1SnController = TextEditingController();
  TextEditingController get iptv1SnController => _iptv1SnController;

  final _iptv2SnController = TextEditingController();
  TextEditingController get iptv2SnController => _iptv2SnController;

  final _iptv3SnController = TextEditingController();
  TextEditingController get iptv3SnController => _iptv3SnController;

  final _routerSnController = TextEditingController();
  TextEditingController get routerSnController => _routerSnController;

  final _dropWire = TextEditingController();
  TextEditingController get dropWire => _dropWire;
  set dropWiretext(String x) => _dropWire.text = x;

  final _powerLevel = TextEditingController();
  TextEditingController get powerLevel => _powerLevel;
  set powerLeveltext(String x) => _powerLevel.text = x;

  final _returnComment = TextEditingController();
  TextEditingController get returnComment => _returnComment;
  set returnCommenttext(String x) => returnComment.text = x;

  final _newFDP = TextEditingController();
  TextEditingController get newFDP => _newFDP;
  set setnewFDP(String x) => _newFDP.text = x;

  final _newFDP1 = TextEditingController();
  TextEditingController get newFDP1 => _newFDP1;

  final _newFDP2 = TextEditingController();
  TextEditingController get newFDP2 => _newFDP2;

  final _newFDP3 = TextEditingController();
  TextEditingController get newFDP3 => _newFDP3;

  final _newFDP4 = TextEditingController();
  TextEditingController get newFDP4 => _newFDP4;

  final _newLoop = TextEditingController();
  TextEditingController get newLoop => _newLoop;

  bool _cusLocVisibility = true;
  bool get cusLocVisibility => _cusLocVisibility;

  bool _ftthVisibility = true;
  bool get ftthVisibility => _ftthVisibility;

  bool _imgVisibility = true;
  bool get imgVisibility => _imgVisibility;

  var _image1;
  get image1 => _image1;
  set image1(x) => _image1 = x;

  bool _img1Visibility = false;
  bool get img1Visibility => _img1Visibility;

  List<String> _imgList = [];
  List<String> get imgList => _imgList;

  //service visibility-----------------
  bool _pryvoiceVisibility = true;
  bool get pryvoiceVisibility => _pryvoiceVisibility;

  bool _secvoiceVisibility = true;
  bool get secvoiceVisibility => _secvoiceVisibility;

  bool _bbVisibility = true;
  bool get bbVisibility => _bbVisibility;

  bool _iptv1Visibility = true;
  bool get iptv1Visibility => _iptv1Visibility;

  bool _iptv2Visibility = true;
  bool get iptv2Visibility => _iptv2Visibility;

  bool _iptv3Visibility = true;
  bool get iptv3Visibility => _iptv3Visibility;

  bool _ontVisibility = true;
  bool get ontVisibility => _ontVisibility;

  bool _attributeVisibility = false;
  bool get attributeVisibility => _attributeVisibility;

  List<NumberList> _items = [];
  List<String> _returnReasons = [];
  List<String> get returnReasons => _returnReasons;

  List<String> _snValidations = [];
  List<String> get snValidations => _snValidations;


  String serviceList = '';
  var char = [];

  void resetValues() {
    _newJob = Job();
    _att = Attributes();
    _newFDP1.text = '';
    _newFDP2.text = '';
    _newFDP3.text = '';
    _newFDP4.text = '';
    serviceList = '';
    char = [];
    _voice1SnController.text = '';
    _voice2SnController.text = '';
    _ontSnController.text = '';
    _iptv1SnController.text = '';
    _iptv2SnController.text = '';
    _iptv3SnController.text = '';
    _dropWire.text = '';
    _routerSnController.text = '';

    _image1 = null;
    _img1Visibility = false;
    _selectedImage = QulaityImage();
    _qualityImgList = [];
    _imgList = [];

    primaryVoice = true;
    secondaryVoice = true;
    bb = true;
    iptv1 = true;
    iptv2 = true;
    iptv3 = true;

    notifyListeners();
  }

  Future<List<NumberList>> loadNoList() async {
    _newJob = Job();
    _items = [];
    final SharedPreferences prefs = await _prefs;
    Map userMap = jsonDecode(prefs.getString(PrefKey.user).toString());
    var user = User.fromJson(userMap);
    Logger().d(user.username);
    await _homeController.getNoList(user.username).then((value) {
      for (var element in value.getData()) {
        //Logger().i(element["CIRCUIT"]);
        if(element["CIRCUIT"] != null) {
          _items.add(NumberList(
              circuit: element["CIRCUIT"],
              soId: element["SO_ID"],
              displayname: element["CIRCUIT"] + ' - ' + element["RTOM"]));
        }
      }
      resetValues();
    });
    return _items;
  }

  Future<Job> getSoDetails(String soid, BuildContext context) async {
    EasyLoading.show();
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
      Logger().i(
          "***************************DELETED******************************");
    }
    Job soDetail = Job();
    resetValues();
    await _homeController.getSODetails(soid).then((value) {
      if (!value.getError()) {
        for (var element in value.getData()) {
          ///Logger().i(element["CIRCUIT"]);
          final split = element["FDP_GPS"] == "," || element["FDP_GPS"] == null
              ? ""
              : element["FDP_GPS"].split(',');

          final cusSplit =
              element["CUS_LOC"] == "," || element["CUS_LOC"] == null
                  ? ""
                  : element["CUS_LOC"].split(',');

          uploadedimages =
              element["IMGS"] == null ? [] : element["IMGS"].split(',');

          soDetail = Job(
              assingedOn: element["ASSIGNED_ON"] ?? '',
              conname: element["CON_NAME"] ?? '',
              customerAddress: element["ADDRESS"] ?? '',
              customerLat: '',
              customerLon: '',
              customerNmae: element["CON_CUS_NAME"] ?? '',
              customerTp: element["CON_TEC_CONTACT"] ?? '',
              dplat: element["FDP_GPS"] == "," || element["FDP_GPS"] == null
                  ? ""
                  : split[0],
              dplon: element["FDP_GPS"] == "," || element["FDP_GPS"] == null
                  ? ""
                  : split[1],
              iptv1: element["IPTV"] ?? '',
              iptv2: element["IPTV_2"] ?? '',
              iptv3: element["IPTV_3"] ?? '',
              lea: element["LEA"],
              orderType: element["ORDER_TYPE"],
              package: element["PACKAGE"] ?? '',
              regId: element["CIRCUIT"] ?? '',
              rtom: element["RTOM"] ?? '',
              soID: element["SO_ID"] ?? '',
              svType: element["SER_TYPE"] ?? '',
              task: element["CON_WORO_TASK_NAME"] ?? '',
              fdp: '${element["FDP"] ?? ''}/${element["FDPLOOP"] ?? ''}',
              status: element["STATUS"],
              voice2: element["VOICE_2"] ?? '',
              appPackage: element["APP_PACKAGE"] ?? '',
              imgs: element["IMGS"] ?? '',
              voiceno: element["CIRCUIT"] ?? '',
              poles: '',
              distance: '',
              outage: UtilFunction.getDuration(DateTime.now()
                  .difference(DateTime.parse(element["ASSIGNED_ON"]))
                  .inSeconds));

          att = Attributes(
            att_cusLat: element["CUS_LOC"] == "," || element["CUS_LOC"] == null
                ? ""
                : cusSplit[1],
            att_cusLon: element["CUS_LOC"] == "," || element["CUS_LOC"] == null
                ? ""
                : cusSplit[0],
            att_dw: element["DW"] ?? '',
            att_powerLevel: element["PLEVEL"] ?? '',
            att_poles: element["POLE_COUNT"] ?? '0',
            att_cpeType: element["PHONECLASS"] ?? '',
            att_cpePurchased: element["PHONEPH"] ?? '',
            att_olt: element["OLT"] ?? '',
          );

          _dropWire.text = element["DW"] ?? '';
          _newFDP.text = element["FDPNEW"] == "/" || element["FDPNEW"] == null
              ? ""
              : element["FDPNEW"];
          Provider.of<MaterialProvider>(context, listen: false).noOfPoles.text =
              element["POLE_COUNT"] ?? '0';
        }
        soDetail.appPackage!.split('').forEach((ch) => char.add(ch));
        _newJob = soDetail;
        loadMaterialDropDown(context);
        getImageList(context);
        changeVisibility();
        if (_newJob.soID!.isEmpty) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: "Closed Service Order. Plese refresh the number list",
          );
        }
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: value.getMsg(),
        );
      }
    });
    EasyLoading.dismiss();
    return soDetail;
  }

  //so cancelation-------------------------
  primarySOChange(bool x) {
    if (x) {
      changeVisibility();
    } else {
      _secvoiceVisibility = false;
      _bbVisibility = false;
      _iptv1Visibility = false;
      _iptv2Visibility = false;
      _iptv3Visibility = false;
    }
  }

  //genaral visibility ----------------------

  initVisibility() {
    _cusLocVisibility = false;
    _ftthVisibility = false;
    _imgVisibility = false;
    _attributeVisibility = false;
    notifyListeners();
  }

  changeVisibility() async {
    serviceList = '';

    if (char.length == 6) {
      if (char[0] == '1') {
        _pryvoiceVisibility = true;
        serviceList += 'Primary Voice\n';
      } else {
        _pryvoiceVisibility = false;
      }
      if (char[1] == '1') {
        _secvoiceVisibility = true;
        serviceList += 'Secoundary Voice\n';
      } else {
        _secvoiceVisibility = false;
      }
      if (char[2] == '1') {
        _bbVisibility = true;
        serviceList += 'Internet\n';
      } else {
        _bbVisibility = false;
      }
      if (char[3] == '1') {
        _iptv1Visibility = true;
        serviceList += 'PeoTv 1\n';
      } else {
        _iptv1Visibility = false;
      }
      if (char[4] == '1') {
        _iptv2Visibility = true;
        serviceList += 'PeoTv 2\n';
      } else {
        _iptv2Visibility = false;
      }
      if (char[5] == '1') {
        _iptv3Visibility = true;
        serviceList += 'PeoTv 3\n';
      } else {
        _iptv3Visibility = false;
      }
    }

    if (_newJob.orderType!.contains('CREATE-UPGRD') && _newJob.status == "1") {
      _pryvoiceVisibility = true;
      _secvoiceVisibility = false;
      _bbVisibility = false;
      _iptv1Visibility = false;
      _iptv2Visibility = false;
      _iptv3Visibility = false;
    }

    if (_att.att_cpeType!.contains('CUSTOMER') && _newJob.status == "2") {
      _pryvoiceVisibility = false;
      _secvoiceVisibility = false;
    }

    // } else {
    //   if (char.length == 6) {
    //     if (char[0] == '1') {
    //       _pryvoiceVisibility = true;
    //       serviceList += 'Primary Voice\n';
    //     } else {
    //       _pryvoiceVisibility = false;
    //     }
    //     if (char[1] == '1') {
    //       _secvoiceVisibility = true;
    //       serviceList += 'Secoundary Voice\n';
    //     } else {
    //       _secvoiceVisibility = false;
    //     }
    //     if (char[2] == '1') {
    //       _bbVisibility = true;
    //       serviceList += 'Internet\n';
    //     } else {
    //       _bbVisibility = false;
    //     }
    //     if (char[3] == '1') {
    //       _iptv1Visibility = true;
    //       serviceList += 'PeoTv 1\n';
    //     } else {
    //       _iptv1Visibility = false;
    //     }
    //     if (char[4] == '1') {
    //       _iptv2Visibility = true;
    //       serviceList += 'PeoTv 2\n';
    //     } else {
    //       _iptv2Visibility = false;
    //     }
    //     if (char[5] == '1') {
    //       _iptv3Visibility = true;
    //       serviceList += 'PeoTv 3\n';
    //     } else {
    //       _iptv3Visibility = false;
    //     }
    //   }
    // }

    switch (_newJob.status) {
      case '1':
        _cusLocVisibility = true;
        _ftthVisibility = false;
        _imgVisibility = false;
        _attributeVisibility = false;

        break;
      case '2':
        _cusLocVisibility = false;
        _ftthVisibility = true;
        _imgVisibility = true;
        _attributeVisibility = true;

        if (_newJob.orderType!.contains('CREATE-UPGRD')) {
          _bbVisibility = true;
        } else {
          _bbVisibility = false;
        }

        break;

      case '3':
        _cusLocVisibility = false;
        _ftthVisibility = false;
        _imgVisibility = true;
        _attributeVisibility = true;
        _newJob.task = 'PROVISIONING';

        if (_newJob.orderType!.contains('CREATE-UPGRD')) {
          _bbVisibility = true;
        } else {
          _bbVisibility = false;
        }

        await setSN();
        break;

      case '4':
        _imgVisibility = true;
        _cusLocVisibility = false;
        _ftthVisibility = false;
        _attributeVisibility = true;

        if (_newJob.orderType!.contains('CREATE-UPGRD')) {
          _bbVisibility = true;
        } else {
          _bbVisibility = false;
        }

        await setSN();
        break;

      case '5':
        _imgVisibility = true;
        _cusLocVisibility = false;
        _ftthVisibility = false;
        _attributeVisibility = true;
        _newJob.task = 'COMPLEATING';

        if (_newJob.orderType!.contains('CREATE-UPGRD')) {
          _bbVisibility = true;
        } else {
          _bbVisibility = false;
        }

        await setSN();
        break;

      case '12':
        _imgVisibility = true;
        _cusLocVisibility = false;
        _ftthVisibility = false;
        _attributeVisibility = false;
        _newJob.task = 'CORRECTING';

        if (_newJob.orderType!.contains('CREATE-UPGRD')) {
          _bbVisibility = true;
        } else {
          _bbVisibility = false;
        }

        await setSN();
        break;

      default:
        _cusLocVisibility = false;
        _ftthVisibility = false;
        _imgVisibility = false;
        _attributeVisibility = false;

        break;
    }

    if (_newJob.svType!.contains('E-IPTV')) {
      _ontVisibility = false;
      _attributeVisibility = false;
    } else {
      _ontVisibility = true;
    }

    notifyListeners();
  }

  loadMaterialDropDown(BuildContext context) {
    Provider.of<MaterialProvider>(context, listen: false)
        .loadMaterialList(context);
    Provider.of<AtributeProvider>(context, listen: false).loadAttList(context);
    Provider.of<MaterialProvider>(context, listen: false).loadPoleList();
    Provider.of<MaterialProvider>(context, listen: false)
        .getaddedMaterialList(newJob.soID!);
  }

  setSN() async {
    await _homeController.getNewFdp(_newJob.soID!).then((value) {
      if (!value.getError()) {
        for (var element in value.getData()) {
          var arr = element["FDP"].toString().split("-");
          _newFDP1.text = arr.length < 0 ? arr[0].toString() : "";
          _newFDP2.text = arr.length < 0 ? arr[1].toString() : "";
          _newFDP3.text = arr.length < 0 ? arr[2].toString() : "";
          _newFDP4.text = arr.length < 0 ? arr[3].toString() : "";
          _newLoop.text = element["LOOP"];
        }
      }
    });

    await _homeController.getSNList(_newJob.soID!).then((value) {
      if (!value.getError()) {
        for (var element in value.getData()) {
          switch (element["TYPE"]) {
            case 'VOICE_CPE_SERIAL_NUMBER_1':
              _voice1SnController.text = element["SERIALNO"];
              break;
            case 'VOICE_CPE_SERIAL_NUMBER_2':
              _voice2SnController.text = element["SERIALNO"];
              break;
            case 'ONT_ROUTER_SERIAL_NUMBER':
              _ontSnController.text = element["SERIALNO"];
              break;
            case 'IPTV_CPE_SERIAL_NUMBER_1':
              _iptv1SnController.text = element["SERIALNO"];
              break;
            case 'IPTV_CPE_SERIAL_NUMBER_2':
              _iptv2SnController.text = element["SERIALNO"];
              break;
            case 'IPTV_CPE_SERIAL_NUMBER_3':
              _iptv3SnController.text = element["SERIALNO"];
              break;
            case 'ADSL_ROUTER_SERIAL_NUMBER':
              _routerSnController.text = element["SERIALNO"];
              break;

            default:
          }
        }
      }
    });
  }

  Future<bool> updateSoStatus(BuildContext context, List<String> resons) async {
    if (_fdpchanged && _newFDP1.text.isEmpty ||
        _fdpchanged && _newFDP2.text.isEmpty ||
        _fdpchanged && _newFDP3.text.isEmpty ||
        _fdpchanged && _newFDP4.text.isEmpty ||
        _fdpchanged && _newLoop.text.isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        text: "Both FDP location and loop need to be filled befor submitting",
      );
      return false;
    }

    if (_pryvoiceVisibility) {
      if (_att.att_cusLat!.isEmpty) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Customer Location Needed",
        );
        return false;
      }

      if (_primaryVoice) {
        if (_bbVisibility && !_bb && _iptv1Visibility && !_iptv1) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: 'Both Broadband and PeoTV Service Orders Cannot be Cancelled',
          );
          return false;
        }

        if (_secvoiceVisibility && !_secondaryVoice) {
          if (resons[1].isEmpty) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: 'Return reason is mandatory!',
            );
            return false;
          }
          _homeController.updateCancelledSo(
              newJob.soID!, 'V-VOICE FTTH', 'SECONDARY', resons[1]);
          char[1] = '0';
        }
        if (_bbVisibility && !_bb) {
          if (resons[2].isEmpty) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: 'Return reason is mandatory!',
            );
            return false;
          }
          if (_newJob.package == 'Double Play - BB') {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text:
                  'Broadband Service Order Cannot be Cancelled in Double Play Requests',
            );
            return false;
          } else {
            _homeController.updateCancelledSo(
                newJob.soID!, 'BB-INTERNET FTTH', '', resons[2]);
            char[2] = '0';
          }
        }
        if (_iptv1Visibility && !_iptv1) {
          if (resons[3].isEmpty) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: 'Return reason is mandatory!',
            );
            return false;
          }
          if (_newJob.package == 'Double Play - PeoTV') {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text:
                  'PeoTv Service Order Cannot be Cancelled in Double Play Requests',
            );
            return false;
          } else {
            _homeController.updateCancelledSo(
                newJob.soID!, 'E-IPTV FTTH', '1', resons[3]);
            char[3] = '0';
          }
        }
        if (_iptv2Visibility && !_iptv2) {
          if (resons[4].isEmpty) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: 'Return reason is mandatory!',
            );
            return false;
          }
          _homeController.updateCancelledSo(
              newJob.soID!, 'E-IPTV FTTH', '2', resons[4]);
          char[4] = '0';
        }
        if (_iptv3Visibility && !_iptv3) {
          if (resons[5].isEmpty) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: 'Return reason is mandatory!',
            );
            return false;
          }
          _homeController.updateCancelledSo(
              newJob.soID!, 'E-IPTV FTTH', '3', resons[5]);
          char[5] = '0';
        }
        var tempstring = '';
        for (var x in char) {
          tempstring += x;
        }
        if (_fdpchanged && _newFDP1.text.isNotEmpty) {
          await _homeController.updateNewFdp(
              _newJob.soID!,
              '${_newFDP1.text}-${_newFDP2.text}-${_newFDP3.text}-${_newFDP4.text}',
              _newLoop.text.toString());
        }
        await _homeController.updateSoPkg(newJob.soID!, tempstring);
        await _homeController
            .updateSoStatus(newJob.soID!, AssetConstants.cusLocOk)
            .then((value) {
          return true;
        });

        return true;
      } else {
        if (resons[0].isEmpty) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: 'Return reason is mandatory!',
          );
          return false;
        }
        if (resons[0] == "POWER LEVEL ISSUE" && _powerLevel.text.isEmpty) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: 'Power level is mandatory!',
          );
          return false;
        }

        await CoolAlert.show(
          context: context,
          type: CoolAlertType.confirm,
          text:
              'Cancelling the Primary Service Order will Cancel all Related Service Orders. Are you Sure ?',
          confirmBtnText: 'Continue',
          cancelBtnText: 'Cancel',
          onConfirmBtnTap: () async {
            await _homeController
                .cancellMainSO(newJob.soID!, resons[0], _returnComment.text)
                .then((value) async {
              if (!value.getError()) {
                if (resons[0] == "POWER LEVEL ISSUE" &&
                    _powerLevel.text.isNotEmpty) {
                  await updatePowerLevel(context);
                }
                await _homeController.updateSoStatus(
                    newJob.soID!, AssetConstants.cancelleSo);
                returnCommenttext = "";
                powerLeveltext = "";
                loadNoList();
                _newJob = Job();
                notifyListeners();
              } else {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  text: value.getMsg(),
                );
              }
            });
            Navigator.of(context).pop(false);
          },
          onCancelBtnTap: () {
            Navigator.of(context).pop(false);
          },
        );
        return true;
      }
    } else {
      if (_iptv1Visibility && _iptv1) {
        await _homeController.updateSoStatus(
            newJob.soID!, AssetConstants.cusLocOk);
        if (_fdpchanged && _newFDP1.text.isNotEmpty) {
          await _homeController.updateNewFdp(
              _newJob.soID!,
              '${_newFDP1.text}-${_newFDP2.text}-${_newFDP3.text}-${_newFDP4.text}',
              _newLoop.text.toString());
        }
        return true;
      } else {
        if (resons[0] == "POWER LEVEL ISSUE" && _powerLevel.text.isEmpty) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: 'Power level is mandatory!',
          );
          return false;
        }

        CoolAlert.show(
          context: context,
          type: CoolAlertType.confirm,
          text:
              'Cancelling the Primary Service Order will Cancel all Related Service Orders. Are you Sure ?',
          confirmBtnText: 'Continue',
          cancelBtnText: 'Cancel',
          onConfirmBtnTap: () {
            _homeController
                .updateCancelledSo(newJob.soID!, 'E-IPTV FTTH', '1', resons[2])
                .then((value) {
              if (!value.getError()) {
                _homeController.updateSoStatus(
                    newJob.soID!, AssetConstants.cancelleSo);
              } else {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  text: value.getMsg(),
                );
              }
            });
          },
          onCancelBtnTap: () {
            return;
          },
        );
        return true;
      }
      return true;
    }
  }

  Future<bool> updateSN(BuildContext context) async {
    if (_ontVisibility) {
      if (_ontSnController.text.isEmpty) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "ONT Serial Number is Mandatory",
        );
        return false;
      }
    }

    if (_ontVisibility) {
      if (!UtilFunction.validateONT(_ontSnController.text,snValidations)) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "ONT Serial Number Validation Failed",
        );
        return false;
      }
    }

    if (_iptv1Visibility) {
      if (_iptv1SnController.text.isEmpty) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "IPTV 1 Setup Box Serial Number is Mandatory",
        );
        return false;
      }
      if (!UtilFunction.validateSTB(_iptv1SnController.text,snValidations)) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "IPTV 1 Setup Box Serial Number Validation Failed",
        );
        return false;
      }
    }

    if (_iptv2Visibility) {
      if (_iptv2SnController.text.isEmpty) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "IPTV 2 Setup Box Serial Number is Mandatory",
        );
        return false;
      }
      if (!UtilFunction.validateSTB(_iptv2SnController.text,snValidations)) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "IPTV 2 Setup Box Serial Number Validation Failed",
        );
        return false;
      }
    }

    if (_iptv3Visibility) {
      if (_iptv3SnController.text.isEmpty) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "IPTV 3 Setup Box Serial Number is Mandatory",
        );
        return false;
      }
      if (!UtilFunction.validateSTB(_iptv3SnController.text,snValidations)) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "IPTV 3 Setup Box Serial Number Validation Failed",
        );
        return false;
      }
    }

    if (_pryvoiceVisibility &&
        _secvoiceVisibility &&
        _voice1SnController.text.isEmpty &&
        _voice2SnController.text.isEmpty &&
        _voice1SnController.text == _voice2SnController.text) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Both Telephones Serial Numbers Cannot be Same",
      );
      return false;
    }

    if (_iptv1Visibility &&
        _iptv2Visibility &&
        _iptv1SnController.text.isNotEmpty &&
        _iptv2SnController.text.isNotEmpty &&
        _iptv1SnController.text == _iptv2SnController.text) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Two Setup Boxes Serial Numbers Cannot be Same",
      );
      return false;
    }

    if (_iptv1Visibility &&
        _iptv3Visibility &&
        _iptv1SnController.text.isNotEmpty &&
        _iptv3SnController.text.isNotEmpty &&
        _iptv1SnController.text == _iptv3SnController.text) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Two Setup Boxes Serial Numbers Cannot be Same",
      );
      return false;
    }

    if (_iptv3Visibility &&
        _iptv2Visibility &&
        _iptv3SnController.text.isNotEmpty &&
        _iptv2SnController.text.isNotEmpty &&
        _iptv3SnController.text == _iptv2SnController.text) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Two Setup Boxes Serial Numbers Cannot be Same",
      );
      return false;
    }

    // if (_fdpchanged && _newFDP1.text.isEmpty ||
    //     _fdpchanged && _newFDP2.text.isEmpty ||
    //     _fdpchanged && _newFDP3.text.isEmpty ||
    //     _fdpchanged && _newFDP4.text.isEmpty ||
    //     _fdpchanged && _newLoop.text.isEmpty) {
    //   CoolAlert.show(
    //     context: context,
    //     type: CoolAlertType.info,
    //     text: "Both FDP location and loop need to be filled befor submitting",
    //   );
    //   return false;
    // }

    if (_pryvoiceVisibility) {
      if (_voice1SnController.text.isNotEmpty) {
        _homeController.insertSN(
            _newJob.soID!, AssetConstants.telephone1, voice1SnController.text);
      }
    }
    if (_secvoiceVisibility) {
      if (_voice2SnController.text.isNotEmpty) {
        _homeController.insertSN(
            _newJob.soID!, AssetConstants.telephone2, _voice2SnController.text);
      }
    }
    if (_ontVisibility) {
      if (_ontSnController.text.isNotEmpty) {
        _homeController.insertSN(
            _newJob.soID!, AssetConstants.ont, _ontSnController.text);
      }
    }
    if (_iptv1Visibility) {
      if (_iptv1SnController.text.isNotEmpty) {
        _homeController.insertSN(
            _newJob.soID!, AssetConstants.iptv1, _iptv1SnController.text);
      }
    }
    if (_iptv2Visibility) {
      if (_iptv2SnController.text.isNotEmpty) {
        _homeController.insertSN(
            _newJob.soID!, AssetConstants.iptv2, _iptv2SnController.text);
      }
    }
    if (_iptv3Visibility) {
      if (_iptv3SnController.text.isNotEmpty) {
        _homeController.insertSN(
            _newJob.soID!, AssetConstants.iptv3, _iptv3SnController.text);
      }
    }

    if (_bbVisibility) {
      if (_routerSnController.text.isNotEmpty) {
        _homeController.insertSN(
            _newJob.soID!, AssetConstants.adslrouter, _routerSnController.text);
      }
    }

    // if (_fdpchanged && _newFDP1.text.isNotEmpty) {
    //   _homeController.updateNewFdp(
    //       _newJob.soID!,
    //       _newFDP1.text.toString() +
    //           '-' +
    //           _newFDP2.text.toString() +
    //           '-' +
    //           _newFDP3.text.toString() +
    //           '-' +
    //           _newFDP4.text.toString(),
    //       _newLoop.text.toString());
    // }

    if (_newJob.svType!.contains('E-IPTV')) {
      await _homeController.updateSoStatus(
          newJob.soID!, AssetConstants.snCaptureOkIptv);
    } else {
      await _homeController.updateSoStatus(
          newJob.soID!, AssetConstants.snCaptureOk);
    }

    return true;
  }

  //Quality Images -----------------------
  Future<List<QulaityImage>> getImageList(BuildContext context) async {
    _imgList = [];
    _qualityImgList = [];
    await _homeController.getImgList(_newJob.soID!).then((value) {
      if (!value.getError()) {
        for (var element in value.getData()) {
          //Logger().d(element["ID"]);
          _qualityImgList.add(QulaityImage(
              id: element["IMAGEID"],
              imgcount: '1',
              imgname: element["IMAGE_DISNAME"],
              mandatory: 'N',
              source: element["SOURCE"] ?? AssetConstants.camera));

          _imgList.add(element["IMAGE_DISNAME"]);
        }
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: value.getMsg(),
        );
      }
    });
    notifyListeners();
    return _qualityImgList;
  }

  Future<void> showImgToCapture(BuildContext context, int index) async {
    if (index == -1) {
      _image1 = null;
      _img1Visibility = false;
      _selectedImage = QulaityImage();
    } else {
      _image1 = null;
      await Provider.of<LocationProvider>(context, listen: false)
          .isLocationEnabled(context)
          .then((value) {
        if (!value) {
          _img1Visibility = false;
          _selectedImage = QulaityImage();
        } else {
          _img1Visibility = true;
          _selectedImage = _qualityImgList[index];
        }
      });
    }
    notifyListeners();
  }

  Future<bool> uploadImgCapture(BuildContext context, String picLat,
      String picLon, bool saveinphone) async {
    if (_selectedImage.imgcount == '') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Please Select Image Type!",
      );
      return false;
    }

    var imageid = _selectedImage.id;
    bool status = true;
    String tempName = DateTime.now().millisecondsSinceEpoch.toString();

    if (_img1Visibility && image1 == null) {
      status = false;
    }

    if (!status) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Please capture an image to upload",
      );
      return false;
    }

    await _homeController.updateImgCount(
        tempName, _selectedImage.imgname, _newJob.soID!, picLon, picLat);

    status = true;
    if (_img1Visibility) {
      await _homeController
          .uploadQualityImg(_newJob.soID!, '${tempName}.jpg', _image1,_newJob.rtom.toString())
          .then((value) {
        if (value.error) {
          if (value.error) {
            status = false;
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: "Photo Uploading Error: ${value.message}  ",
            );
          }
        } else {
          if (saveinphone) {
            GallerySaver.saveImage(File(_image1).path);
          }
        }
      });
    }
    //}
    // });

    if (status) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Photo Uploading Success!",
      );

      //imgList.remove(_selectedImage.imgname);
      uploadedimages.add(imageid);

      return false;
    } else {
      return true;
    }
  }

  Future<void> updateDropWire(BuildContext context) async {
    if (_dropWire.text.isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Drop Wire Length Needed",
      );
      return;
    }

    if (int.parse(_dropWire.text) > 999) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Drop Wire Length Should be Less Than 1km",
      );
      return;
    }
    await _homeController.updateDropWire(
        _newJob.soID!, _dropWire.text, _newJob.voiceno!);
    // .then((value) => getSoDetails(_newJob.soID!, context));
    att.att_dw = _dropWire.text;
    MaterialProvider matProvider =
        Provider.of<MaterialProvider>(context, listen: false);
    matProvider.getaddedMaterialList(_newJob.soID!);
    notifyListeners();
    CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      text: "Update Success",
    );

    return;
  }

  Future<void> updatePowerLevel(BuildContext context) async {
    if (_powerLevel.text.isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Power Level Needed",
      );
      return;
    }

    await _homeController.updateAttributes(
        _newJob.soID!,
        _powerLevel.text,
        Provider.of<LoginProvider>(context, listen: false).appUser.username,
        AssetConstants.powerLevel);
    MaterialProvider matProvider =
        Provider.of<MaterialProvider>(context, listen: false);
    matProvider.getaddedMaterialList(_newJob.soID!);
    notifyListeners();
    CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      text: "Update Success",
    );

    return;
  }

  Future<void> closeSO(BuildContext context) async {
    _homeController
        .updateSoStatus(_newJob.soID!, AssetConstants.closeSo)
        .then((value) async {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Service Order Completed!",
      );
      _newJob = Job();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  Future<bool> compleateAttUpdate(BuildContext context) async {
    if (_att.att_cusLat!.isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Customer Location Needed",
      );
      return false;
    }
    if (!_newJob.svType!.contains('E-IPTV')) {
      if (_att.att_poles!.isEmpty) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "No of Poles Needed",
        );
        return false;
      }
      if (_att.att_dw!.isEmpty) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Drop Wire Length Needed",
        );
        return false;
      }
    }

    EasyLoading.show();
    await _homeController
        .updateSoStatus(_newJob.soID!, AssetConstants.attUpdateOk)
        .then((value) async {
      EasyLoading.dismiss();
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Task Completed!",
      );

      getSoDetails(newJob.soID!, context).then((value) {
        getImageList(context);
      });
      return true;
    });
    return true;
  }

  compleateSO(BuildContext context) {
    if (_imgList.isNotEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        text:
            "There are Pending Images to Upload. \nAre You Sure You Want to Continue?",
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        onConfirmBtnTap: () {
          closeSO(context);
          Navigator.pop(context);
          return;
        },
        onCancelBtnTap: () {
          Navigator.pop(context);
          return;
        },
      );
    } else {
      closeSO(context);
      Navigator.pop(context);
    }
  }

  //get return reason list
  Future<List<String>> loadResonList() async {
    _items = [];
    _returnReasons = [];
    await _homeController.getReasonList().then((value) {
      for (var element in value.getData()) {
        _returnReasons.add(element["REASON"]);
      }
      resetValues();
    });
    return _returnReasons;
  }

  //get Serial No Validation list
  Future<List<String>> loadSnValidation() async {
    _items = [];
    _snValidations = [];
    await _homeController.getSnValidationList().then((value) {
      Logger().i(value.data);
      for (var element in value.getData()) {

        if(element["SERVICE"] == "ONT")   {
          _snValidations.add("ONT_"+element["SNSTART"]);
        }
        if(element["SERVICE"] == "STB")   {
          _snValidations.add("STB_"+element["SNSTART"]);
        }

      }
      Logger().i(_snValidations);
      resetValues();
    });
    return _snValidations;
  }


}
