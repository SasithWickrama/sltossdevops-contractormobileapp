import 'package:flutter/material.dart';

import '../utils/size_config.dart';

class CustomCardView extends StatelessWidget {
  CustomCardView({
    Key? key,
    required this.wigetList,
    this.margin = 0,
  }) : super(key: key);

  var wigetList;
  double margin;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin == 0
          ? const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10)
          : const EdgeInsets.only(left: 2, right: 2, top: 3, bottom: 3),
      color: Colors.white70,
      elevation: 5,
      shadowColor: Colors.black,
      child: SizedBox(
        width: SizeConfig.w(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: wigetList,
            ),
          ),
        ),
      ),
    );
  }
}
