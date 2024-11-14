import 'package:contractor_app/utils/constants/app_colors.dart';
import 'package:contractor_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalInput extends StatelessWidget {
  NormalInput({
    Key? key,
    this.hint = "",
    this.isObscureText = false,
    this.inputType = TextInputType.text,
    required this.customController,
    this.width = 0,
    this.enable = true,
    this.mxlines = 1,
    this.charcount = 0,
  }) : super(key: key);

  final String hint;
  final bool isObscureText;
  final TextInputType inputType;
  final TextEditingController customController;
  final double width;
  final enable;
  final int mxlines;
  final int charcount;
  final Color enablecolour = Color(0xFF4DA1B0);
  final Color misscolour = Color(0xFFFF8A8A);
  final Color disabledcolour = Color(0xFFAEAEAE);

  @override
  Widget build(BuildContext context) {
    Color bgcolour = enable ? const Color(0xFF4DA1B0) : const Color(0xFFAEAEAE);
    return Container(
      margin: const EdgeInsets.only(top: 0),
      alignment: Alignment.center,
      // height: SizeConfig.h(context) / 20,
      width: width == 0 ? SizeConfig.w(context) / 1.8 : width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        //color: const Color(0xFF4DA1B0),

        color: bgcolour,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextField(
                // maxLength: charcount == 0 ? null : charcount,
                enabled: enable,
                controller: customController,
                obscureText: isObscureText,
                maxLines: mxlines,
                cursorColor: Colors.white70,
                keyboardType: inputType,
                style: GoogleFonts.inter(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                onChanged: (value) {
                  if (charcount != 0 && value.length > charcount) {
                    customController.text =
                        customController.text.substring(0, charcount);
                  }
                  if (charcount != 0 && value.length < charcount) {
                    bgcolour = misscolour;
                  }
                },
                // onEditingComplete: () {
                //   if (charcount != 0 &&
                //       customController.text.length != charcount) {
                //     customController.text =
                //         customController.text.substring(0, charcount);
                //   }
                // },
                decoration: InputDecoration(
                    hintText: hint,
                    fillColor: bgcolour,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 18.0,
                      color: bgcolour, // Colors.white70,
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
