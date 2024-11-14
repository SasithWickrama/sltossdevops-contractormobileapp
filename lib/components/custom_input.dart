import 'package:contractor_app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    this.hint = "",
    this.isObscureText = false,
    this.inputType = TextInputType.text,
    required this.customController,
    this.enable = true,
  }) : super(key: key);

  final String hint;
  final bool isObscureText;
  final TextInputType inputType;
  final TextEditingController customController;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextField(
              textAlignVertical: TextAlignVertical.top,
              enabled: enable,
              controller: customController,
              obscureText: isObscureText,
              keyboardType: inputType,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: AppColors.inputbackgroud,
                filled: true,
                contentPadding: enable
                    ? const EdgeInsets.only(top: 30, left: 5, right: 5)
                    : const EdgeInsets.only(top: 5, left: 5, right: 5),
                labelText: hint,
                labelStyle:
                    const TextStyle(fontSize: 25.0, color: Colors.black),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
          // Positioned(
          //   left: 10,
          //   top: 3,
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 3),
          //     color: Colors.white,
          //     child: Text('Email ID'),
          //   ),
          // )
        ],
      ),
    );
  }
}
