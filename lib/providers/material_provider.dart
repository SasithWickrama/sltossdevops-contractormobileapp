import 'package:contractor_app/controllers/home_controller.dart';
import 'package:contractor_app/providers/login_provider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/custom_text.dart';
import '../components/normal_input.dart';
import '../components/pole_radiolist.dart';
import '../components/select_search.dart';
import '../models/insert_material.dart';
import '../models/quality_image.dart';
import '../utils/size_config.dart';
import 'home_provider.dart';

class MaterialProvider extends ChangeNotifier {
  List<String> _mterialList = [];
  List<String> get mterialList => _mterialList;

  List<String> _polelist = [];
  List<String> get polelist => _polelist;

  List<InsertMaterials> _mymterialList = [];
  List<InsertMaterials> get mymterialList => _mymterialList;

  final _attvalue = TextEditingController();
  TextEditingController get attvalue => _attvalue;

  final _noOfPoles = TextEditingController();
  TextEditingController get noOfPoles => _noOfPoles;

  final _polesn = TextEditingController();
  TextEditingController get polesn => _polesn;

  late String selectedMaterial = "";
  late String selectedPole = "";

  int _poleRemoveid = 0;
  int get poleRemoveid => _poleRemoveid;
  void setPoleRemoveid(int x) => _poleRemoveid = x;

  final HomeController _homeController = HomeController();

  Future<void> loadMaterialList(BuildContext context) async {
    _mterialList = [];
    await _homeController
        .getFTTHMaterialList(Provider.of<LoginProvider>(context, listen: false)
            .appUser
            .contractor)
        .then((value) {
      for (var element in value.getData()) {
        _mterialList
            .add(element["UNIT_DESIG"] + "[" + element["DISPLAY_DESC"] + "]");
      }
    });
  }

  Future<void> getaddedMaterialList(String soid) async {
    _mymterialList = [];
    await _homeController.getaddedMaterialList(soid).then((value) {
      for (var element in value.getData()) {
        _mymterialList.add(InsertMaterials(
          dis: element["UNIT_DESIG"],
          metid: element["MET_ID"],
          p0: element["P0"],
          p1: element["P1"] ?? '',
          sn: element["SN"] ?? '',
          soid: element["SOID"],
          stype: element["STYPE"] ?? '',
        ));
      }
    });
    notifyListeners();
  }

  Future<void> loadPoleList() async {
    _polelist = [];
    await _homeController.getPoleList().then((value) {
      for (var element in value.getData()) {
        _polelist.add(element["UNIT_DESIG"]);
      }
    });
  }

  Future<void> insertMaterial(BuildContext context) async {
    if (selectedMaterial.isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Please select a material type",
      );
      return;
    }

    if (_attvalue.text.isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Material usage ammount needed",
      );
      return;
    }

    final splitted = selectedMaterial.split('[');

    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    await _homeController
        .insertMaterial(homeProvider.newJob.soID!, _attvalue.text,
            homeProvider.newJob.voiceno!, splitted[0], "")
        .then((value) {
      Logger().d(value);
    });
    selectedMaterial = "";
    _attvalue.text = "";
    notifyListeners();
    getaddedMaterialList(homeProvider.newJob.soID!);
    CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      text: "Update Success",
    );
    return;
  }

  Future<void> insertPole(BuildContext context) async {
    if (selectedPole.isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Please select a pole type",
      );
      return;
    }

    if (_polesn.text.isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Pole Serial Number needed",
      );
      return;
    }

    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    await _homeController.insertMaterial(homeProvider.newJob.soID!, "1",
        homeProvider.newJob.voiceno!, selectedPole, _polesn.text);

    Logger().d(homeProvider.att.att_poles);
    Logger().d((int.parse(homeProvider.att.att_poles!) + 1).toString());
    await _homeController.updatePoles(
        homeProvider.newJob.soID!, (int.parse(_noOfPoles.text) + 1).toString());
    await _homeController.insertPoleImage(homeProvider.newJob.soID!,
        (int.parse(homeProvider.att.att_poles!) + 1).toString());

    homeProvider.getImageList(context);

    homeProvider.att.att_poles = (int.parse(_noOfPoles.text) + 1).toString();
    _noOfPoles.text = (int.parse(_noOfPoles.text) + 1).toString();

    selectedPole = "";
    _polesn.text = "";
    notifyListeners();
    getaddedMaterialList(homeProvider.newJob.soID!);
    CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      text: "Update Success",
    );
    return;
  }

  Future<void> deleteMaterial(BuildContext context, InsertMaterials mat) async {
    _poleRemoveid = 0;
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    if (mat.dis!.contains("PL-")) {
      selectedPole = mat.dis!;
      polesn.text = mat.sn!;
      CoolAlert.show(
        context: context,
        type: CoolAlertType.custom,
        title: "Edit Pole Data",
        text: "** Delete will Remove All Poles Image Data. ",
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(text: 'Pole S/N', fontSize: 15),
            SelectSearch(
              text: "Pole Type",
              displayitems: polelist,
              selectedValue: selectedPole,
              onTap: (value) {
                if (value == null) {
                  selectedPole = "";
                } else {
                  selectedPole = value;
                }
              },
            ),
            const SizedBox(
              height: 5,
            ),
            const CustomText(text: 'Pole S/N', fontSize: 15),
            NormalInput(
              customController: polesn,
              width: SizeConfig.w(context) / 1.2,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  text: 'Delete',
                  onTap: (() async {
                    Navigator.pop(context);
                    await _homeController.deleteMaterial(mat.metid!);
                    await _homeController.updatePoles(homeProvider.newJob.soID!,
                        (int.parse(_noOfPoles.text) - 1).toString());
                    await _homeController
                        .removePoleImgs(homeProvider.newJob.soID!);
                    homeProvider.att.att_poles =
                        (int.parse(_noOfPoles.text) - 1).toString();
                    homeProvider.getImageList(context);
                    noOfPoles.text =
                        (int.parse(_noOfPoles.text) - 1).toString();
                    polesn.text = "";
                    selectedPole = "";
                    getaddedMaterialList(homeProvider.newJob.soID!);
                  }),
                  btnwidth: SizeConfig.h(context) * 0.1,
                ),
                CustomButton(
                  text: 'Update',
                  onTap: (() async {
                    Navigator.pop(context);
                    await _homeController.updateMaterial(
                        mat.metid!, polesn.text, selectedPole);
                    polesn.text = "";
                    selectedPole = "";
                    getaddedMaterialList(homeProvider.newJob.soID!);
                  }),
                  btnwidth: SizeConfig.h(context) * 0.1,
                )
              ],
            )
          ],
        ),
        confirmBtnText: "Cancel",
        onConfirmBtnTap: () {
          Navigator.pop(context);
          polesn.text = "";
          selectedPole = "";
          notifyListeners();
        },
      );
    } else if (mat.dis == "FTTH-DW") {
      await _homeController.deleteMaterial(mat.metid!);
      homeProvider.att.att_dw = "";
      homeProvider.dropWiretext = "";
      notifyListeners();
    } else {
      await _homeController.deleteMaterial(mat.metid!);
    }
    getaddedMaterialList(homeProvider.newJob.soID!);
  }
}
