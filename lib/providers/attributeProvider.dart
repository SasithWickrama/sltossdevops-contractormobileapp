import 'package:contractor_app/controllers/home_controller.dart';
import 'package:contractor_app/providers/home_provider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_provider.dart';

class AtributeProvider extends ChangeNotifier {
  List<String> _attList = [];
  List<String> get attList => _attList;

  final _attvalue = TextEditingController();
  TextEditingController get attvalue => _attvalue;

  late String selectedAtt = "";

  final HomeController _homeController = HomeController();

  Future<void> loadAttList(BuildContext context) async {
    _attList = [];
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    await _homeController.getAttList(homeProvider.newJob.soID!).then((value) {
      for (var element in value.getData()) {
        _attList.add(element["ATT_NAME"]);
      }
    });
  }

  Future<void> insertAttribute(BuildContext context) async {
    if (selectedAtt.isEmpty) {
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
        text: "Attribute value needed",
      );
      return;
    }

    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    await _homeController.updateAttributes(
        homeProvider.newJob.soID!,
        _attvalue.text,
        Provider.of<LoginProvider>(context, listen: false).appUser.username,
        selectedAtt);

    homeProvider.getImageList(context);

    _attvalue.text = "";
    notifyListeners();
    CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      text: "Update Success",
    );
    return;
  }
}
