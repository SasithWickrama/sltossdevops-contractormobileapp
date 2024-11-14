import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../utils/constants/asset_constants.dart';
import '../utils/constants/theam_config.dart';
import 'custom_text.dart';

class DisplayTextwithTitle extends StatelessWidget {
  DisplayTextwithTitle({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  String title;
  String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: title,
            fontSize: TheamConstants.lableTitleSize,
            color: AppColors.logoBlue,
            fontWeight: TheamConstants.lableTitleWeight,
          ),
          CustomText(
            text: value,
            textAlign: TextAlign.left,
            fontSize: TheamConstants.lableTextSize,
            color: AppColors.logoBlue,
            fontWeight: TheamConstants.lableTextWeight,
          ),
        ],
      ),
    );
  }
}
