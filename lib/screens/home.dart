import 'dart:async';

import 'package:contractor_app/components/custom_text.dart';
import 'package:contractor_app/models/job.dart';
import 'package:contractor_app/providers/home_provider.dart';
import 'package:contractor_app/providers/location_provider.dart';
import 'package:contractor_app/screens/home_att_update.dart';
import 'package:contractor_app/screens/home_image_capture.dart';
import 'package:contractor_app/screens/home_sn_capture.dart';
import 'package:contractor_app/screens/home_so_confirmation.dart';
import 'package:contractor_app/screens/home_so_details.dart';
import 'package:contractor_app/screens/login.dart';
import 'package:contractor_app/utils/constants/app_colors.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tab_container/tab_container.dart';
import '../components/select_search.dart';
import '../utils/constants/theam_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedValue;

  List<String> soList = [];
  List<String> cctList = [];
  bool checkedval = false;
  bool locationbtnVisibility = true;
  Timer? mytimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LocationProvider>(context, listen: false)
          .startLocationMonitor(context);
      // Provider.of<MaterialProvider>(context, listen: false).loadMaterialList();
      Provider.of<HomeProvider>(context, listen: false).initVisibility();
      Provider.of<HomeProvider>(context, listen: false).loadResonList();
      Provider.of<HomeProvider>(context, listen: false).loadSnValidation();
      Provider.of<HomeProvider>(context, listen: false)
          .loadNoList()
          .then((value) {
        for (var element in value) {
          soList.add(element.soId);
          cctList.add(element.circuit);
        }
      });
    });
  }

  @override
  void dispose() {
    mytimer?.cancel();
    super.dispose();
  }

//  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final providerHome = Provider.of<HomeProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        CoolAlert.show(
          context: context,
          showCancelBtn: true,
          type: CoolAlertType.confirm,
          text: "Do You Want to Logout?",
          confirmBtnText: 'Yes',
          cancelBtnText: 'No',
          onConfirmBtnTap: () async {
            final cacheDir = await getTemporaryDirectory();

            if (cacheDir.existsSync()) {
              cacheDir.deleteSync(recursive: true);
            }
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const LoginScreen();
            }), (r) {
              return false;
            });
            return;
          },
          onCancelBtnTap: () {
            Navigator.of(context).pop(false);
          },
        );
        return false;
      },
      child: LiquidPullToRefresh(
        color: const Color(0xFF21899C),
        backgroundColor: const Color(0xFFF5F5F5),
        onRefresh: () {
          soList = [];
          cctList = [];
          providerHome.newJob = Job();
          providerHome.resetValues();
          providerHome.initVisibility();
          providerHome.loadResonList();
          return providerHome.loadNoList().then((value) {
            for (var element in value) {
              soList.add(element.soId);
              cctList.add(element.displayname);
            }
          });
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: TheamConstants.mainPadding,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SelectSearch(
                        text: "Voice Number",
                        displayitems: cctList,
                        selectedValue: providerHome.newJob.regId.toString(),
                        onTap: (value) async {
                          Logger().e(value);
                          if (value != null) {
                            final cacheDir = await getTemporaryDirectory();
                            if (cacheDir.existsSync()) {
                              cacheDir.deleteSync(recursive: true);
                              print("catched cleared");
                            }

                            providerHome
                                .getSoDetails(
                                    soList[cctList.indexOf(value.toString())],
                                    context)
                                .then((value) {
                              checkedval = false;
                              locationbtnVisibility = true;
                              //  providerHome.getImageList(context);
                            });
                          } else {
                            setState(() {
                              providerHome.newJob = Job();
                              providerHome.initVisibility();
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SoDetails(),
                      const SoConfirmation(),
                      Visibility(
                        visible: providerHome.imgVisibility,
                        child: SizedBox(
                          height: 1020,
                          child: TabContainer(
                            isStringTabs: false,
                            color: Color(0xFF4DA1B0),
                            tabs: const [
                              CustomText(
                                text: 'Images',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.logoBlue,
                              ),
                              CustomText(
                                text: 'Scan',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.logoBlue,
                              ),
                              CustomText(
                                text: 'Materials',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.logoBlue,
                              ),
                            ],
                            children: const [
                              ImageCapture(),
                              SnCapture(),
                              AttCapture(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
