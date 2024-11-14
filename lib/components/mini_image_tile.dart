import 'package:flutter/material.dart';

import '../utils/constants/asset_constants.dart';

class MiniImageTile extends StatelessWidget {
  const MiniImageTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius : BorderRadius.circular(15),
      child: Image.network(AssetConstants.dummyImage,
        width: 70,
        height: 70,
        fit: BoxFit.cover,),
    );
  }
}
