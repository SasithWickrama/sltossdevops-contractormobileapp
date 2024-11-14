import 'package:contractor_app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/custom_cardview.dart';
import '../components/custom_text.dart';
import '../components/display_text_with_title.dart';
import '../components/normal_input.dart';
import '../components/select_search.dart';
import '../models/job.dart';
import '../providers/home_provider.dart';
import '../providers/location_provider.dart';
import '../utils/size_config.dart';

class SoConfirmation extends StatefulWidget {
  const SoConfirmation({super.key});

  @override
  State<SoConfirmation> createState() => _SoConfirmationState();
}

class _SoConfirmationState extends State<SoConfirmation> {
  String primaryReason = '';
  String secondaryReason = '';
  String internetReason = '';
  String iptv1Reason = '';
  String iptv2Reason = '';
  String iptv3Reason = '';
  bool powerlevel = false;
  bool cusconfirmBtnVisibility = true;
  var locationbtnVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Provider.of<HomeProvider>(context).cusLocVisibility
        ? Consumer<HomeProvider>(builder: (context, providerValue, child) {
            return CustomCardView(
              wigetList: <Widget>[
                Table(
                  children: [
                    TableRow(
                      children: [
                        DisplayTextwithTitle(
                          title: 'Feasibility Check',
                          value: '',
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  Visibility(
                                    visible: providerValue.pryvoiceVisibility,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.0,
                                          bottom: 4,
                                          left: 10,
                                          right: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const CustomText(
                                                  text: 'All Service Orders',
                                                  fontSize: 15),
                                              FlutterSwitch(
                                                activeColor:
                                                    AppColors.orangeShade1,
                                                activeText: 'Proceed',
                                                inactiveText: 'Return',
                                                width: SizeConfig.w(context) *
                                                    0.38,
                                                height: 35,
                                                valueFontSize: 15.0,
                                                toggleSize: 45.0,
                                                value:
                                                    providerValue.primaryVoice,
                                                borderRadius: 30.0,
                                                padding: 8.0,
                                                showOnOff: true,
                                                onToggle: (value) {
                                                  setState(() {
                                                    primaryReason = "";
                                                    providerValue.primaryVoice =
                                                        value;
                                                    providerValue
                                                        .primarySOChange(value);
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                          Visibility(
                                            visible:
                                                !providerValue.primaryVoice,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SelectSearch(
                                                  text: "Return Reason",
                                                  displayitems: providerValue
                                                      .returnReasons,
                                                  selectedValue: primaryReason,
                                                  onTap: (value) {
                                                    primaryReason = value ?? '';
                                                    if (primaryReason ==
                                                        "POWER LEVEL ISSUE") {
                                                      powerlevel = true;
                                                    } else {
                                                      powerlevel = false;
                                                    }
                                                    setState(() {});
                                                  },
                                                ),
                                                Visibility(
                                                  visible: powerlevel,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const CustomText(
                                                          text: 'Power Level',
                                                          fontSize: 15),
                                                      Row(
                                                        children: [
                                                          NormalInput(
                                                            width: SizeConfig.w(
                                                                    context) /
                                                                1.2,
                                                            customController:
                                                                providerValue
                                                                    .powerLevel,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const CustomText(
                                                    text: 'Comments',
                                                    fontSize: 15),
                                                Row(
                                                  children: [
                                                    NormalInput(
                                                      mxlines: 3,
                                                      width: SizeConfig.w(
                                                              context) /
                                                          1.2,
                                                      inputType: TextInputType
                                                          .multiline,
                                                      customController:
                                                          providerValue
                                                              .returnComment,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(
                                children: [
                                  Visibility(
                                    visible: providerValue.secvoiceVisibility,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 40.0,
                                            bottom: 4,
                                            left: 10,
                                            right: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const CustomText(
                                                    text: 'Secondary Voice',
                                                    fontSize: 15),
                                                FlutterSwitch(
                                                  activeColor:
                                                      AppColors.orangeShade1,
                                                  disabled: providerValue
                                                      .secondaryVoiceenabled,
                                                  activeText: 'Proceed',
                                                  inactiveText: 'Return',
                                                  width: SizeConfig.w(context) *
                                                      0.38,
                                                  height: 35,
                                                  valueFontSize: 15.0,
                                                  toggleSize: 45.0,
                                                  value: providerValue
                                                      .secondaryVoice,
                                                  borderRadius: 30.0,
                                                  padding: 8.0,
                                                  showOnOff: true,
                                                  onToggle: (value) {
                                                    setState(() {
                                                      secondaryReason = "";
                                                      providerValue
                                                              .secondaryVoice =
                                                          value;
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                            Visibility(
                                              visible:
                                                  !providerValue.secondaryVoice,
                                              child: SelectSearch(
                                                text: "Return Reason",
                                                displayitems:
                                                    providerValue.returnReasons,
                                                selectedValue: secondaryReason,
                                                onTap: (value) {
                                                  secondaryReason = value ?? '';
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(
                                children: [
                                  Visibility(
                                    visible: providerValue.bbVisibility,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 40.0,
                                          bottom: 4,
                                          left: 10,
                                          right: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const CustomText(
                                                  text: 'Internet',
                                                  fontSize: 15),
                                              FlutterSwitch(
                                                activeColor:
                                                    AppColors.orangeShade1,
                                                disabled:
                                                    providerValue.bbenabled,
                                                activeText: 'Proceed',
                                                inactiveText: 'Return',
                                                width: SizeConfig.w(context) *
                                                    0.38,
                                                height: 35,
                                                valueFontSize: 15.0,
                                                toggleSize: 45.0,
                                                value: providerValue.bb,
                                                borderRadius: 30.0,
                                                padding: 8.0,
                                                showOnOff: true,
                                                onToggle: (value) {
                                                  setState(() {
                                                    internetReason = "";
                                                    providerValue.bb = value;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                          Visibility(
                                            visible: !providerValue.bb,
                                            child: SelectSearch(
                                              text: "Return Reason",
                                              displayitems:
                                                  providerValue.returnReasons,
                                              selectedValue: internetReason,
                                              onTap: (value) {
                                                internetReason = value ?? '';
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Visibility(
                                    visible: providerValue.iptv1Visibility,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 40.0,
                                          bottom: 4,
                                          left: 10,
                                          right: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const CustomText(
                                                  text: 'PeoTv 1',
                                                  fontSize: 15),
                                              FlutterSwitch(
                                                activeColor:
                                                    AppColors.orangeShade1,
                                                disabled:
                                                    providerValue.iptv1enabled,
                                                activeText: 'Proceed',
                                                inactiveText: 'Return',
                                                width: SizeConfig.w(context) *
                                                    0.38,
                                                height: 35,
                                                valueFontSize: 15.0,
                                                toggleSize: 45.0,
                                                value:
                                                    Provider.of<HomeProvider>(
                                                            context)
                                                        .iptv1,
                                                borderRadius: 30.0,
                                                padding: 8.0,
                                                showOnOff: true,
                                                onToggle: (value) {
                                                  setState(() {
                                                    iptv1Reason = "";
                                                    providerValue.iptv1 = value;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                          Visibility(
                                            visible: !providerValue.iptv1,
                                            child: SelectSearch(
                                              text: "Return Reason",
                                              displayitems:
                                                  providerValue.returnReasons,
                                              selectedValue: iptv1Reason,
                                              onTap: (value) {
                                                iptv1Reason = value ?? '';
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Visibility(
                                    visible: providerValue.iptv2Visibility,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 40.0,
                                          bottom: 4,
                                          left: 10,
                                          right: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const CustomText(
                                                  text: 'PeoTv 2',
                                                  fontSize: 15),
                                              FlutterSwitch(
                                                activeColor:
                                                    AppColors.orangeShade1,
                                                disabled:
                                                    providerValue.iptv2enabled,
                                                activeText: 'Proceed',
                                                inactiveText: 'Return',
                                                width: SizeConfig.w(context) *
                                                    0.38,
                                                height: 35,
                                                valueFontSize: 15.0,
                                                toggleSize: 45.0,
                                                value: providerValue.iptv2,
                                                borderRadius: 30.0,
                                                padding: 8.0,
                                                showOnOff: true,
                                                onToggle: (value) {
                                                  setState(() {
                                                    iptv2Reason = "";
                                                    providerValue.iptv2 = value;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                          Visibility(
                                            visible: !providerValue.iptv2,
                                            child: SelectSearch(
                                              text: "Return Reason",
                                              displayitems:
                                                  providerValue.returnReasons,
                                              selectedValue: iptv2Reason,
                                              onTap: (value) {
                                                iptv2Reason = value ?? '';
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Visibility(
                                    visible: providerValue.iptv3Visibility,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 40.0,
                                          bottom: 4,
                                          left: 10,
                                          right: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const CustomText(
                                                  text: 'PeoTv 3',
                                                  fontSize: 15),
                                              FlutterSwitch(
                                                activeColor:
                                                    AppColors.orangeShade1,
                                                disabled:
                                                    providerValue.iptv3enabled,
                                                activeText: 'Proceed',
                                                inactiveText: 'Return',
                                                width: SizeConfig.w(context) *
                                                    0.38,
                                                height: 35,
                                                valueFontSize: 15.0,
                                                toggleSize: 45.0,
                                                value: providerValue.iptv3,
                                                borderRadius: 30.0,
                                                padding: 8.0,
                                                showOnOff: true,
                                                onToggle: (value) {
                                                  setState(() {
                                                    iptv3Reason = "";
                                                    providerValue.iptv3 = value;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                          Visibility(
                                            visible: !providerValue.iptv3,
                                            child: SelectSearch(
                                              text: "Return Reason",
                                              displayitems:
                                                  providerValue.returnReasons,
                                              selectedValue: iptv3Reason,
                                              onTap: (value) {
                                                iptv3Reason = value ?? '';
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const CustomText(
                                              text: 'FDP Changed?',
                                              fontSize: 15),
                                          FlutterSwitch(
                                            activeColor: AppColors.orangeShade1,
                                            activeText: 'Yes',
                                            inactiveText: 'No',
                                            width: SizeConfig.w(context) * 0.3,
                                            height: 35,
                                            valueFontSize: 15.0,
                                            toggleSize: 45.0,
                                            value: providerValue.fdpchanged,
                                            borderRadius: 30.0,
                                            padding: 8.0,
                                            showOnOff: true,
                                            onToggle: (value) {
                                              setState(() {
                                                providerValue.fdpchanged =
                                                    value;
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Visibility(
                                    visible: providerValue.fdpchanged,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const CustomText(
                                                text: 'Proper FDP Number',
                                                fontSize: 15),
                                            Row(
                                              children: [
                                                NormalInput(
                                                  charcount: 3,
                                                  width:
                                                      SizeConfig.w(context) / 7,
                                                  customController:
                                                      providerValue.newFDP1,
                                                ),
                                                const CustomText(
                                                    text: '-', fontSize: 15),
                                                NormalInput(
                                                  charcount: 5,
                                                  width:
                                                      SizeConfig.w(context) / 6,
                                                  customController:
                                                      providerValue.newFDP2,
                                                ),
                                                const CustomText(
                                                    text: '-', fontSize: 15),
                                                NormalInput(
                                                  charcount: 5,
                                                  width:
                                                      SizeConfig.w(context) / 6,
                                                  customController:
                                                      providerValue.newFDP3,
                                                  inputType:
                                                      TextInputType.number,
                                                ),
                                                const CustomText(
                                                    text: '-', fontSize: 15),
                                                NormalInput(
                                                  charcount: 3,
                                                  width:
                                                      SizeConfig.w(context) / 7,
                                                  customController:
                                                      providerValue.newFDP4,
                                                  inputType:
                                                      TextInputType.number,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const CustomText(
                                                text: 'Loop', fontSize: 15),
                                            NormalInput(
                                              charcount: 2,
                                              customController:
                                                  providerValue.newLoop,
                                              width: SizeConfig.w(context) / 7,
                                              inputType: TextInputType.number,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Visibility(
                                    visible:
                                        providerValue.att.att_cusLat!.isEmpty,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, bottom: 10),
                                      child: Consumer<LocationProvider>(
                                        builder: (context, value, child) =>
                                            CustomButton(
                                          btnwidth: SizeConfig.h(context) * 0.8,
                                          btncolour: locationbtnVisibility
                                              ? AppColors.primaryOrange
                                              : AppColors.orangeShade1,
                                          text: "Get Customer Location",
                                          onTap: () async {
                                            await value.updateCusLoc(
                                                providerValue.newJob.soID!,
                                                context);
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, bottom: 10),
                                  child: CustomButton(
                                    text: 'Submit',
                                    btnwidth: SizeConfig.h(context) * 0.8,
                                    onTap: () {
                                      setState(() {
                                        cusconfirmBtnVisibility = false;
                                      });
                                      providerValue.updateSoStatus(context, [
                                        primaryReason,
                                        secondaryReason,
                                        internetReason,
                                        iptv1Reason,
                                        iptv2Reason,
                                        iptv3Reason
                                      ]).then((value) {
                                        if (value) {
                                          providerValue
                                              .getSoDetails(
                                                  providerValue.newJob.soID!,
                                                  context)
                                              .then((value) {
                                            if (providerValue.newJob.status ==
                                                "1") {
                                              setState(() {
                                                cusconfirmBtnVisibility = true;
                                              });
                                            }
                                            setState(() {});
                                          });
                                        } else {
                                          setState(() {
                                            cusconfirmBtnVisibility = true;
                                          });
                                        }
                                      });
                                    },
                                  ),
                                )
                              ])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            );
          })
        : Container();
  }
}
