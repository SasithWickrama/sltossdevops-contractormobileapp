import 'package:contractor_app/providers/attributeProvider.dart';
import 'package:contractor_app/providers/location_provider.dart';
import 'package:contractor_app/providers/material_provider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tab_container/tab_container.dart';

import '../components/custom_button.dart';
import '../components/custom_cardview.dart';
import '../components/custom_text.dart';
import '../components/normal_input.dart';
import '../components/select_search.dart';
import '../providers/home_provider.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/theam_config.dart';
import '../utils/size_config.dart';

class AttCapture extends StatefulWidget {
  const AttCapture({super.key});

  @override
  State<AttCapture> createState() => _AttCaptureState();
}

class _AttCaptureState extends State<AttCapture> {
  var locationbtnVisibility = true;
  var isLoading = false;
  bool saveBtnVisibility = true;
  @override
  Widget build(BuildContext context) {
    return Provider.of<HomeProvider>(context).attributeVisibility
        ? Consumer3<HomeProvider, MaterialProvider, AtributeProvider>(builder:
            (context, providerValue, materialprovider, attributeprovider,
                child) {
            return CustomCardView(
              wigetList: <Widget>[
                SizedBox(
                  height: 925,
                  child: TabContainer(
                    isStringTabs: false,
                    color: Color(0xFF4DA1B0),
                    tabs: const [
                      CustomText(
                        text: 'Insert',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.logoBlue,
                      ),
                      CustomText(
                        text: 'Usage Details',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.logoBlue,
                      ),
                    ],
                    children: <Widget>[
                      CustomCardView(
                        margin: 10,
                        wigetList: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     const CustomText(
                          //         text: 'Power Level', fontSize: 15),
                          //     Row(
                          //       children: [
                          //         NormalInput(
                          //           enable: providerValue
                          //               .att.att_powerLevel!.isEmpty,
                          //           customController: providerValue.powerLevel,
                          //           inputType: TextInputType.number,
                          //         ),
                          //         const SizedBox(
                          //           width: 10,
                          //         ),
                          //         Visibility(
                          //           visible: providerValue
                          //               .att.att_powerLevel!.isEmpty,
                          //           child: CustomButton(
                          //             text: 'Save',
                          //             onTap: (() {
                          //               providerValue.updatePowerLevel(context);
                          //             }),
                          //             btnwidth: SizeConfig.h(context) * 0.1,
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ],
                          // ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                  text: 'Other Attributes', fontSize: 15),
                              SelectSearch(
                                text: "Attributes",
                                displayitems: attributeprovider.attList,
                                selectedValue: attributeprovider.selectedAtt,
                                onTap: (value) {
                                  if (value == null) {
                                    attributeprovider.selectedAtt = "";
                                  } else {
                                    attributeprovider.selectedAtt = value;
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(text: 'Value', fontSize: 15),
                              Row(
                                children: [
                                  NormalInput(
                                    customController:
                                        attributeprovider.attvalue,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Visibility(
                                    visible: saveBtnVisibility,
                                    child: CustomButton(
                                      text: 'Save',
                                      onTap: (() {
                                        setState(() {
                                          saveBtnVisibility = false;
                                        });
                                        attributeprovider
                                            .insertAttribute(context)
                                            .then((value) {
                                          attributeprovider
                                              .loadAttList(context)
                                              .then((value) {
                                            setState(() {
                                              saveBtnVisibility = true;
                                            });
                                          });
                                        });
                                      }),
                                      btnwidth: SizeConfig.h(context) * 0.1,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: TheamConstants.dividerThikness,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                  text: 'Drop Wire Length [m]', fontSize: 15),
                              Row(
                                children: [
                                  NormalInput(
                                    enable: providerValue.att.att_dw!.isEmpty,
                                    customController: providerValue.dropWire,
                                    inputType: TextInputType.number,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Visibility(
                                    visible: providerValue.att.att_dw!.isEmpty,
                                    child: CustomButton(
                                      text: 'Save',
                                      onTap: (() {
                                        providerValue.updateDropWire(context);
                                      }),
                                      btnwidth: SizeConfig.h(context) * 0.1,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: TheamConstants.dividerThikness,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                  text: 'New Poles Details', fontSize: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                      text: 'Total Number of New Poles',
                                      fontSize: 15),
                                  Row(
                                    children: [
                                      NormalInput(
                                        enable: false,
                                        customController:
                                            materialprovider.noOfPoles,
                                        inputType: TextInputType.number,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SelectSearch(
                                text: "Pole Type",
                                displayitems: materialprovider.polelist,
                                selectedValue: materialprovider.selectedPole,
                                onTap: (value) {
                                  if (value == null) {
                                    materialprovider.selectedPole = "";
                                  } else {
                                    materialprovider.selectedPole = value;
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(text: 'Pole S/N', fontSize: 15),
                              Row(
                                children: [
                                  NormalInput(
                                    customController: materialprovider.polesn,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Visibility(
                                    visible: providerValue.newJob.status ==
                                                '2' ||
                                            providerValue.newJob.status ==
                                                '3' ||
                                            providerValue.newJob.status == '4'
                                        ? true
                                        : false,
                                    child: Visibility(
                                      visible: saveBtnVisibility,
                                      child: CustomButton(
                                        text: 'Save',
                                        onTap: (() {
                                          setState(() {
                                            saveBtnVisibility = false;
                                          });
                                          materialprovider
                                              .insertPole(context)
                                              .then((value) {
                                            setState(() {
                                              saveBtnVisibility = true;
                                            });
                                          });
                                        }),
                                        btnwidth: SizeConfig.h(context) * 0.1,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: TheamConstants.dividerThikness,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                  text: 'Other Materials', fontSize: 15),
                              SelectSearch(
                                text: "Materials Type",
                                displayitems: materialprovider.mterialList,
                                selectedValue:
                                    materialprovider.selectedMaterial,
                                onTap: (value) {
                                  if (value == null) {
                                    materialprovider.selectedMaterial = "";
                                  } else {
                                    materialprovider.selectedMaterial = value;
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(text: 'Amount', fontSize: 15),
                              Row(
                                children: [
                                  NormalInput(
                                    customController: materialprovider.attvalue,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Visibility(
                                    visible: saveBtnVisibility,
                                    child: CustomButton(
                                      text: 'Save',
                                      onTap: (() {
                                        setState(() {
                                          saveBtnVisibility = false;
                                        });
                                        materialprovider
                                            .insertMaterial(context)
                                            .then((value) {
                                          setState(() {
                                            saveBtnVisibility = true;
                                          });
                                        });
                                      }),
                                      btnwidth: SizeConfig.h(context) * 0.1,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Visibility(
                            visible: providerValue.att.att_cusLat!.isEmpty,
                            child: Consumer<LocationProvider>(
                              builder: (context, value, child) => CustomButton(
                                btnwidth: SizeConfig.h(context) * 0.8,
                                btncolour: locationbtnVisibility
                                    ? AppColors.primaryOrange
                                    : AppColors.orangeShade1,
                                text: "Get Customer Location",
                                onTap: () async {
                                  await value.updateCusLoc(
                                      providerValue.newJob.soID!, context);
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomCardView(
                        wigetList: [
                          const Text('Tap and hold the record to delete.'),
                          DataTable(
                            columns: const [
                              // DataColumn(label: Text('Type')),
                              DataColumn(label: Text('Description')),
                              DataColumn(label: Text('S/N')),
                              DataColumn(label: Text('Amount')),
                            ],
                            rows: List.generate(
                                materialprovider.mymterialList.length, (index) {
                              return DataRow(
                                cells: [
                                  DataCell(Container(
                                      child: Text(
                                    materialprovider.mymterialList[index].dis
                                        .toString(),
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ))),
                                  DataCell(Container(
                                      child: Text(
                                    materialprovider.mymterialList[index].sn
                                        .toString(),
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ))),
                                  DataCell(Container(
                                      child: Text(
                                    materialprovider.mymterialList[index].p0
                                        .toString(),
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  )))
                                ],
                                onLongPress: () {
                                  // Logger().i(
                                  //     "**************************************");
                                  // Logger().i(materialprovider
                                  //     .mymterialList[index].dis
                                  //     .toString()
                                  //     .contains("PL-"));
                                  if ((materialprovider.mymterialList[index].dis
                                              .toString()
                                              .contains("PL-") ||
                                          materialprovider
                                                  .mymterialList[index].dis
                                                  .toString() ==
                                              "FTTH-DW") &&
                                      int.tryParse(providerValue.newJob.status
                                              .toString())! >
                                          4) {
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.info,
                                      text:
                                          'Cannot Delete This Record After Installation Complete !',
                                      confirmBtnText: 'OK',
                                      onConfirmBtnTap: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    );
                                  } else {
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.confirm,
                                      text:
                                          'Are You Sure You Want to Delete This Record ?',
                                      cancelBtnText: 'No',
                                      confirmBtnText: 'Yes',
                                      onConfirmBtnTap: () async {
                                        Navigator.pop(context);
                                        await materialprovider.deleteMaterial(
                                            context,
                                            materialprovider
                                                .mymterialList[index]);
                                        setState(() {});
                                      },
                                    );
                                  }
                                },
                              );
                            }),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          })
        : Container();
  }
}
