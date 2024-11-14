import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../utils/size_config.dart';
import 'custom_text.dart';

class ServiceList extends StatelessWidget {
  ServiceList({
    super.key,
    required this.title,
    required this.ischecked,
    required this.ontap,
    this.isenabled = true,
  });

  String title;
  bool ischecked;
  Function() ontap;
  bool isenabled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 4.0, bottom: 4, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: 20,
            ),
            FlutterSwitch(
              disabled: isenabled,
              activeText: 'Proceed',
              inactiveText: 'Cancel',
              width: SizeConfig.w(context) * 0.38,
              height: 40,
              valueFontSize: 25.0,
              toggleSize: 45.0,
              value: ischecked,
              borderRadius: 30.0,
              padding: 8.0,
              showOnOff: true,
              onToggle: (value) => {ischecked = !ischecked},
            )
          ],
        ),
      ),
    );
  }
}
