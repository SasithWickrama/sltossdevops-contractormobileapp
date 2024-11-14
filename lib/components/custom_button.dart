import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../utils/size_config.dart';
import 'custom_loader.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.btnwidth = 0,
    this.btncolour = AppColors.primaryOrange,
  }) : super(key: key);

  final String text;
  final Function() onTap;
  final bool isLoading;
  final double btnwidth;
  final Color btncolour;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isLoading,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: btnwidth == 0 ? SizeConfig.h(context) * 0.2 : btnwidth,
          height: SizeConfig.h(context) / 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: btncolour, borderRadius: BorderRadius.circular(8)),
          child: isLoading
              ? CustomLoader()
              : CustomText(
                  text: text,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
        ),
      ),
    );
  }
}
