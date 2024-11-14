import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import 'custom_input.dart';

class ExpandableCardView extends StatelessWidget {
  ExpandableCardView({
    Key? key,
    required this.title,
    this.subTitle = '',
    this.widgetList,
  }) : super(key: key);

  String title;
  String subTitle;
  var widgetList;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: AppColors.logoBlue,
                      ),
                    )),
                collapsed: Text(
                  subTitle,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgetList,
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 2, right: 2, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
