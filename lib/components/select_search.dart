import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

import '../utils/constants/app_colors.dart';
import '../utils/size_config.dart';

class SelectSearch extends StatelessWidget {
  SelectSearch({
    super.key,
    required this.selectedValue,
    required this.displayitems,
    required this.onTap,
    required this.text,
  });

  String selectedValue;
  List<String> displayitems;
  ValueSetter<String?> onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 10, bottom: 0, left: 20, right: 10),
      alignment: Alignment.center,
      height: SizeConfig.h(context) / 15,
      width: SizeConfig.w(context) / 1.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF4DA1B0),
      ),
      child: DropdownSearch<String>(
        selectedItem: selectedValue == '' ? null : selectedValue,
        clearButtonProps: const ClearButtonProps(isVisible: true),
        // onBeforePopupOpening: (selectedItem) {
        //   FocusScope.of(context).unfocus();
        //   return Future.value(true);
        // },
        popupProps: const PopupProps.dialog(
          showSearchBox: true,
          showSelectedItems: true,
          // disabledItemFn: (String s) => s.startsWith('I'),
        ),
        items: displayitems,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            hintText: text,
            hintStyle: GoogleFonts.inter(
              fontSize: 15.0,
              color: AppColors.logoBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onChanged: (value) {
          FocusScope.of(context).unfocus();
          onTap(value);
        },
      ),
    );
    ;
  }
}
