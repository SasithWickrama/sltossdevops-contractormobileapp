import 'package:contractor_app/utils/constants/app_colors.dart';
import 'package:contractor_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginInput extends StatelessWidget {
  LoginInput({
    Key? key,
    this.hint = "",
    this.isObscureText = false,
    this.inputType = TextInputType.text,
    required this.customController,
    required this.sideIcon,
    required this.fnode,
  }) : super(key: key);

  final String hint;
  final bool isObscureText;
  final TextInputType inputType;
  final TextEditingController customController;
  var sideIcon;
  FocusNode fnode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      height: SizeConfig.h(context) / 15,
      width: SizeConfig.w(context) / 1.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF4DA1B0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              sideIcon,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 16,
            ),
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextField(
                focusNode: fnode,
                controller: customController,
                obscureText: isObscureText,
                maxLines: 1,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.text,
                style: GoogleFonts.inter(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 18.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
