import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/custom_cardview.dart';
import '../components/custom_text.dart';
import '../components/normal_input.dart';
import '../providers/home_provider.dart';
import '../utils/constants/app_colors.dart';
import '../utils/size_config.dart';
import '../utils/util_functions.dart';

class SnCapture extends StatefulWidget {
  const SnCapture({super.key});

  @override
  State<SnCapture> createState() => _SnCaptureState();
}

class _SnCaptureState extends State<SnCapture> {
  bool submitBtnVisibility = true;
  @override
  Widget build(BuildContext context) {
    return Provider.of<HomeProvider>(context).ftthVisibility
        ? Consumer<HomeProvider>(builder: (context, providerValue, child) {
            return CustomCardView(
              wigetList: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: providerValue.pryvoiceVisibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(text: 'Telephone S/N', fontSize: 15),
                          Row(
                            children: [
                              NormalInput(
                                customController:
                                    providerValue.voice1SnController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                text: 'Scan',
                                onTap: (() {
                                  UtilFunction.scan(
                                      providerValue.voice1SnController, "TP1");
                                }),
                                btnwidth: SizeConfig.h(context) * 0.1,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.secvoiceVisibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                              text: 'Telephone 2 S/N', fontSize: 15),
                          Row(
                            children: [
                              NormalInput(
                                customController:
                                    providerValue.voice2SnController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                text: 'Scan',
                                onTap: (() {
                                  UtilFunction.scan(
                                      providerValue.voice2SnController, "TP2");
                                }),
                                btnwidth: SizeConfig.h(context) * 0.1,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.ontVisibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(text: 'ONT S/N', fontSize: 15),
                          Row(
                            children: [
                              NormalInput(
                                customController: providerValue.ontSnController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                text: 'Scan',
                                onTap: (() {
                                  UtilFunction.scan(
                                      providerValue.ontSnController, "ONT");
                                }),
                                btnwidth: SizeConfig.h(context) * 0.1,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.iptv1Visibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                              text: 'PeoTv STB 1 MAC S/N', fontSize: 15),
                          Row(
                            children: [
                              NormalInput(
                                customController:
                                    providerValue.iptv1SnController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                text: 'Scan',
                                onTap: (() {
                                  UtilFunction.scan(
                                      providerValue.iptv1SnController, "IPTV1");
                                }),
                                btnwidth: SizeConfig.h(context) * 0.1,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.iptv2Visibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                              text: 'PeoTv STB 2 MAC S/N', fontSize: 15),
                          Row(
                            children: [
                              NormalInput(
                                customController:
                                    providerValue.iptv2SnController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                text: 'Scan',
                                onTap: (() {
                                  UtilFunction.scan(
                                      providerValue.iptv2SnController, "IPTV2");
                                }),
                                btnwidth: SizeConfig.h(context) * 0.1,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.iptv3Visibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                              text: 'PeoTv STB 3 MAC S/N', fontSize: 15),
                          Row(
                            children: [
                              NormalInput(
                                customController:
                                    providerValue.iptv3SnController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                text: 'Scan',
                                onTap: (() {
                                  UtilFunction.scan(
                                      providerValue.iptv3SnController, "IPTV3");
                                }),
                                btnwidth: SizeConfig.h(context) * 0.1,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.bbVisibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                              text: 'ADSL Router S/N[Reaturning]',
                              fontSize: 15),
                          Row(
                            children: [
                              NormalInput(
                                customController:
                                    providerValue.routerSnController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                text: 'Scan',
                                onTap: (() {
                                  UtilFunction.scan(
                                      providerValue.routerSnController,
                                      "ROUTER");
                                }),
                                btnwidth: SizeConfig.h(context) * 0.1,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         const CustomText(
                    //             text: 'FDP Changed?', fontSize: 15),
                    //         FlutterSwitch(
                    //           activeColor: AppColors.orangeShade1,
                    //           activeText: 'Yes',
                    //           inactiveText: 'No',
                    //           width: SizeConfig.w(context) * 0.3,
                    //           height: 35,
                    //           valueFontSize: 15.0,
                    //           toggleSize: 45.0,
                    //           value: providerValue.fdpchanged,
                    //           borderRadius: 30.0,
                    //           padding: 8.0,
                    //           showOnOff: true,
                    //           onToggle: (value) {
                    //             setState(() {
                    //               providerValue.fdpchanged = value;
                    //             });
                    //           },
                    //         )
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // Visibility(
                    //   visible: providerValue.fdpchanged,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           const CustomText(
                    //               text: 'Proper FDP Number', fontSize: 15),
                    //           Row(
                    //             children: [
                    //               NormalInput(
                    //                 charcount: 3,
                    //                 width: SizeConfig.w(context) / 7,
                    //                 customController: providerValue.newFDP1,
                    //               ),
                    //               const CustomText(text: '-', fontSize: 15),
                    //               NormalInput(
                    //                 charcount: 5,
                    //                 width: SizeConfig.w(context) / 6,
                    //                 customController: providerValue.newFDP2,
                    //               ),
                    //               const CustomText(text: '-', fontSize: 15),
                    //               NormalInput(
                    //                 charcount: 5,
                    //                 width: SizeConfig.w(context) / 6,
                    //                 customController: providerValue.newFDP3,
                    //                 inputType: TextInputType.number,
                    //               ),
                    //               const CustomText(text: '-', fontSize: 15),
                    //               NormalInput(
                    //                 charcount: 3,
                    //                 width: SizeConfig.w(context) / 7,
                    //                 customController: providerValue.newFDP4,
                    //                 inputType: TextInputType.number,
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //       Column(
                    //         children: [
                    //           const CustomText(text: 'Loop', fontSize: 15),
                    //           NormalInput(
                    //             charcount: 2,
                    //             customController: providerValue.newLoop,
                    //             width: SizeConfig.w(context) / 7,
                    //             inputType: TextInputType.number,
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Visibility(
                      visible: submitBtnVisibility,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: CustomButton(
                          text: 'Submit',
                          btnwidth: SizeConfig.h(context) * 0.8,
                          onTap: () {
                            setState(() {
                              submitBtnVisibility = false;
                            });
                            providerValue.updateSN(context).then((value) {
                              submitBtnVisibility = true;
                              if (value) {
                                providerValue
                                    .getSoDetails(
                                        providerValue.newJob.soID!, context)
                                    .then(
                                  (value) {
                                    setState(() {});
                                  },
                                );
                              } else {
                                setState(() {
                                  submitBtnVisibility = true;
                                });
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          })
        : Consumer<HomeProvider>(builder: (context, providerValue, child) {
            return CustomCardView(
              wigetList: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: providerValue.pryvoiceVisibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomText(text: 'Telephone S/N', fontSize: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NormalInput(
                                enable: false,
                                customController:
                                    providerValue.voice1SnController,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.secvoiceVisibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomText(
                              text: 'Telephone 2 S/N', fontSize: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NormalInput(
                                enable: false,
                                customController:
                                    providerValue.voice2SnController,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.ontVisibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomText(text: 'ONT S/N', fontSize: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NormalInput(
                                enable: false,
                                customController: providerValue.ontSnController,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.iptv1Visibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomText(
                              text: 'PeoTv STB 1 MAC S/N', fontSize: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NormalInput(
                                enable: false,
                                customController:
                                    providerValue.iptv1SnController,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.iptv2Visibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomText(
                              text: 'PeoTv STB 2 MAC S/N', fontSize: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NormalInput(
                                enable: false,
                                customController:
                                    providerValue.iptv2SnController,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.iptv3Visibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomText(
                              text: 'PeoTv STB 3 MAC S/N', fontSize: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NormalInput(
                                enable: false,
                                customController:
                                    providerValue.iptv3SnController,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.bbVisibility,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomText(
                              text: 'ADSL Router S/N[Reaturning]',
                              fontSize: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NormalInput(
                                enable: false,
                                customController:
                                    providerValue.routerSnController,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                                text: 'New FDP Name / Loop', fontSize: 15),
                            Row(
                              children: [
                                NormalInput(
                                  enable: false,
                                  customController: providerValue.newFDP,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            );
          });
  }
}
