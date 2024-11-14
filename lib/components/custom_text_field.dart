import 'package:contractor_app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hint = "",
    this.isObscureText = false,
    this.inputType = TextInputType.text,
    required this.customController,
  }) : super(key: key);

  final String hint;
  final bool isObscureText;
  final TextInputType inputType;
  final TextEditingController customController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(20.0),
      child: Stack(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          child: TextField(
            controller: customController,
            obscureText: isObscureText,
            keyboardType: inputType,
            textAlign: TextAlign.center,
            decoration:  InputDecoration(
              labelText: hint,
              labelStyle: TextStyle(
                color: AppColors.logoBlue,
                fontSize: 23,
              ),
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3),
            color: Colors.white,
            child: Text('Label'),
          ),
        )
      ]),
    );
  }
}
