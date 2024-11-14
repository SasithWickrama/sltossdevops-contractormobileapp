import 'package:contractor_app/providers/material_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class PoleRadio extends StatefulWidget {
  PoleRadio({super.key});

  @override
  State<PoleRadio> createState() => _PoleRadioState();
}

class _PoleRadioState extends State<PoleRadio> {
  @override
  Widget build(BuildContext context) {
    List<Widget> polelist = <Widget>[];
    var temp = int.parse(
        Provider.of<MaterialProvider>(context, listen: false).noOfPoles.text);
    while (temp > 0) {
      polelist.add(ListTile(
        title: Text('Pole ${temp}'),
        leading: Radio(
          value: temp,
          groupValue: Provider.of<MaterialProvider>(context, listen: false)
              .poleRemoveid,
          onChanged: (value) {
            Logger().d(value);
            Provider.of<MaterialProvider>(context, listen: false)
                .setPoleRemoveid(value!);
            setState(() {});
          },
        ),
      ));
      temp--;
    }

    return Column(
      children: polelist,
    );
  }
}
