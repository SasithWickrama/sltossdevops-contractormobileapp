import 'package:contractor_app/components/custom_text.dart';
import 'package:contractor_app/components/login_button.dart';
import 'package:contractor_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../components/login_input.dart';
import '../providers/login_provider.dart';
import '../utils/constants/asset_constants.dart';
import '../utils/constants/theam_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool boxVisibility = true;
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode otpFocusNode = FocusNode();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IgnorePointer(
        ignoring: false,
        child: SafeArea(
          child: Padding(
            padding: TheamConstants.mainPadding,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: -34,
                  top: 181.0,
                  child: SvgPicture.string(
                    // Group 3178
                    '<svg viewBox="-34.0 181.0 99.0 99.0" ><path transform="translate(-34.0, 181.0)" d="M 74.25 0 L 99 49.5 L 74.25 99 L 24.74999618530273 99 L 0 49.49999618530273 L 24.7500057220459 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-26.57, 206.25)" d="M 0 0 L 42.07500076293945 16.82999992370605 L 84.15000152587891 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(15.5, 223.07)" d="M 0 56.42999649047852 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    width: SizeConfig.h(context) / 8,
                    height: SizeConfig.h(context) / 8,
                  ),
                ),
                Positioned(
                  right: -52,
                  top: 45.0,
                  child: SvgPicture.string(
                    // Group 3177
                    '<svg viewBox="288.0 45.0 139.0 139.0" ><path transform="translate(288.0, 45.0)" d="M 104.25 0 L 139 69.5 L 104.25 139 L 34.74999618530273 139 L 0 69.5 L 34.75000762939453 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(298.42, 80.45)" d="M 0 0 L 59.07500076293945 23.63000106811523 L 118.1500015258789 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(357.5, 104.07)" d="M 0 79.22999572753906 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    width: SizeConfig.h(context) / 5,
                    height: SizeConfig.h(context) / 5,
                  ),
                ),
                Positioned(
                  right: SizeConfig.h(context) / 7,
                  bottom: SizeConfig.h(context) / 5,
                  child: SvgPicture.string(
                    // Group 3177
                    '<svg viewBox="288.0 45.0 139.0 139.0" ><path transform="translate(288.0, 45.0)" d="M 104.25 0 L 139 69.5 L 104.25 139 L 34.74999618530273 139 L 0 69.5 L 34.75000762939453 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(298.42, 80.45)" d="M 0 0 L 59.07500076293945 23.63000106811523 L 118.1500015258789 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(357.5, 104.07)" d="M 0 79.22999572753906 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    width: SizeConfig.h(context) / 7,
                    height: SizeConfig.h(context) / 7,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomText(
                      fontSize: TheamConstants.smlableTitleSize,
                      text:
                          "By SLT IT Solutions Development ${AssetConstants.version}",
                      color: Colors.white,
                      fontWeight: TheamConstants.smlableTitleWeight,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        fontSize: TheamConstants.h1FontSize,
                        text: 'Sign In',
                        color: Colors.white,
                        fontWeight: TheamConstants.h1FontWeight,
                      ),
                      LoginInput(
                        hint: 'User Name',
                        fnode: nameFocusNode,
                        sideIcon: Icons.person,
                        customController: Provider.of<LoginProvider>(context)
                            .userNameController,
                      ),
                      Visibility(
                        maintainSize: false,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: !boxVisibility,
                        child: LoginInput(
                          hint: 'OTP',
                          fnode: otpFocusNode,
                          sideIcon: Icons.password,
                          isObscureText: true,
                          customController:
                              Provider.of<LoginProvider>(context).otpController,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<LoginProvider>(
                        builder: (context, value, child) => LoginButton(
                          isLoading: isloading,
                          text: boxVisibility ? 'Request OTP' : 'Login',
                          onTap: () {
                            //EasyLoading.show();
                            setState(() {
                              isloading = true;
                            });
                            value
                                .validateInput(context)
                                .then((value) => setState(() {
                                      boxVisibility =
                                          Provider.of<LoginProvider>(context,
                                                  listen: false)
                                              .loginstatus;
                                      otpFocusNode.requestFocus();
                                      isloading = false;
                                      // EasyLoading.dismiss();
                                    }));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
