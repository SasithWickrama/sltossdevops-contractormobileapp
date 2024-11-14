import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/custom_cardview.dart';
import '../components/custom_text.dart';
import '../components/display_text_with_title.dart';
import '../components/mini_icon_button.dart';
import '../providers/home_provider.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/asset_constants.dart';
import '../utils/constants/theam_config.dart';
import '../utils/size_config.dart';
import '../utils/util_functions.dart';

class SoDetails extends StatefulWidget {
  const SoDetails({super.key});

  @override
  State<SoDetails> createState() => _SoDetailsState();
}

class _SoDetailsState extends State<SoDetails> {
  bool installBtnVisibility = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, providerValue, child) {
      return CustomCardView(
        wigetList: <Widget>[
          const CustomText(
            text: 'Customer Name & Address',
            fontSize: TheamConstants.lableTitleSize,
            color: AppColors.logoBlue,
            fontWeight: TheamConstants.lableTitleWeight,
          ),
          CustomText(
            text: providerValue.newJob.customerNmae!,
            fontSize: TheamConstants.lableTextSize,
            color: AppColors.logoBlue,
            fontWeight: TheamConstants.lableTextWeight,
          ),
          CustomText(
            text: providerValue.newJob.customerAddress!,
            fontSize: TheamConstants.lableTextSize,
            color: AppColors.logoBlue,
            fontWeight: TheamConstants.lableTextWeight,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MiniIconButton(
                    displayIcon: Icon(Icons.call),
                    displayText: providerValue.newJob.customerTp!,
                    visibilitycheck: providerValue.newJob.customerTp!,
                    pressedFun: () {
                      UtilFunction.callNumber(
                          Provider.of<HomeProvider>(context, listen: false)
                              .newJob
                              .customerTp!);
                    }),
                MiniIconButton(
                    displayIcon: Icon(Icons.directions),
                    displayText: 'Directions',
                    visibilitycheck: providerValue.newJob.customerLat!,
                    pressedFun: () {
                      // UtilFunction.gotoMap(providerValue.newJob.customerLat!,
                      //     providerValue.newJob.customerLon!, context);
                      UtilFunction.openMap(
                          providerValue.newJob.customerLat!,
                          providerValue.newJob.customerLon!,
                          "Customer Location");
                    }),
              ],
            ),
          ),
          const Divider(
            thickness: TheamConstants.dividerThikness,
          ),
          Table(
            children: [
              TableRow(
                children: [
                  DisplayTextwithTitle(
                    title: 'Service Order ID',
                    value: providerValue.newJob.soID!,
                  ),
                  DisplayTextwithTitle(
                    title: 'RTOM',
                    value: providerValue.newJob.rtom!,
                  ),
                ],
              ),
              TableRow(
                children: [
                  DisplayTextwithTitle(
                    title: 'Order Type',
                    value: providerValue.newJob.orderType!,
                  ),
                  DisplayTextwithTitle(
                    title: 'Service Type',
                    value: providerValue.newJob.svType!,
                  ),
                ],
              ),
              TableRow(
                children: [
                  DisplayTextwithTitle(
                    title: 'Package',
                    value: providerValue.newJob.package!,
                  ),
                  DisplayTextwithTitle(
                    title: 'Contractor',
                    value: providerValue.newJob.conname!,
                  ),
                ],
              ),
              TableRow(
                children: [
                  DisplayTextwithTitle(
                    title: 'Pending Task',
                    value: providerValue.newJob.task!,
                  ),
                  DisplayTextwithTitle(
                    title: 'WO Elapsed Time',
                    value: providerValue.newJob.outage!,
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            thickness: TheamConstants.dividerThikness,
          ),
          Table(
            children: [
              TableRow(
                children: [
                  DisplayTextwithTitle(
                    title: 'FDP / Port',
                    value: providerValue.newJob.fdp!,
                  ),
                  MiniIconButton(
                      displayIcon: Icon(Icons.directions),
                      displayText: 'Directions',
                      visibilitycheck: providerValue.newJob.dplat!,
                      pressedFun: () {
                        UtilFunction.openMap(providerValue.newJob.dplat!,
                            providerValue.newJob.dplon!, "FDP Location");
                      }),
                ],
              ),
              TableRow(
                children: [
                  DisplayTextwithTitle(
                    title: 'Est. # Poles Needed',
                    value: Provider.of<HomeProvider>(context).newJob.poles!,
                  ),
                  DisplayTextwithTitle(
                    title: 'Distance From FDP',
                    value: Provider.of<HomeProvider>(context).newJob.distance!,
                  ),
                ],
              ),
              TableRow(
                children: [
                  DisplayTextwithTitle(
                    title: 'Phone Class',
                    value: Provider.of<HomeProvider>(context).att.att_cpeType!,
                  ),
                  DisplayTextwithTitle(
                    title: 'Phone Purchased From',
                    value: Provider.of<HomeProvider>(context)
                        .att
                        .att_cpePurchased!,
                  ),
                ],
              ),
              TableRow(
                children: [
                  DisplayTextwithTitle(
                    title: 'OLT Type',
                    value: Provider.of<HomeProvider>(context).att.att_olt!,
                  ),
                  DisplayTextwithTitle(
                    title: '',
                    value: '',
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            thickness: TheamConstants.dividerThikness,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DisplayTextwithTitle(
                  title: 'Requested Services',
                  value: providerValue.serviceList),
            ],
          ),
          Visibility(
            visible: providerValue.newJob.status == '4',
            child: Column(
              children: [
                const Divider(
                  thickness: TheamConstants.dividerThikness,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                  child: Center(
                    child: CustomButton(
                      text: 'Complete Installation Task',
                      btnwidth: SizeConfig.w(context) / 1.2,
                      onTap: () {
                        setState(() {
                          installBtnVisibility = false;
                        });
                        providerValue.compleateAttUpdate(context).then((value) {
                          if (value) {
                            setState(() {
                              installBtnVisibility = true;
                            });
                          } else {
                            setState(() {
                              installBtnVisibility = false;
                            });
                          }
                          setState(() {});
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Visibility(
          //   visible: providerValue.newJob.status == '5',
          //   child: Column(
          //     children: [
          //       const Divider(
          //         thickness: TheamConstants.dividerThikness,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 20.0, bottom: 10),
          //         child: Center(
          //           child: CustomButton(
          //             text: 'Complete SO',
          //             btnwidth: SizeConfig.w(context) / 1.2,
          //             onTap: () {
          //               providerValue.compleateSO(context);
          //             },
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      );
    });
  }
}
