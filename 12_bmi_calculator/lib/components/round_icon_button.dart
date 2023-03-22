import 'package:flutter/material.dart';

import '../constants.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton(
      {super.key, required this.iconData, required this.onPressed});

  final IconData iconData;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6,
      focusElevation: 6,
      hoverElevation: 8,
      highlightElevation: 12,
      disabledElevation: 6,
      constraints: const BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: const CircleBorder(),
      fillColor: kDarkGrey,
      onPressed: onPressed,
      child: Icon(
        iconData,
        //color: kWhite,
      ),
    );
  }
}
