import 'package:flutter/material.dart';

const kWhite = Color(0xFFABD1C6);
const kBlack = Color(0xFF001E1D);

final kRollHistoryCloseButton = SizedBox(
  height: 48,
  child: AspectRatio(
    aspectRatio: 1.0 / 1.0,
    child: Image.asset(
      'assets/images/close-unpressed.png',
    ),
  ),
);

const kRollHistoryEmptyMessage = Center(
  child: Text(
    'No dice roll history yet. Cast your dice with the "Roll Dice" button!\n— Ori',
    style: TextStyle(
      fontSize: 22.6274,
      color: kBlack,
    ),
  ),
);

const kRollHistoryTitle = Center(
  child: Text(
    'Roll History',
    style: TextStyle(
      letterSpacing: 2.0,
      fontWeight: FontWeight.bold,
      fontSize: 26.9087,
      color: kBlack,
    ),
  ),
);

const kRollHistoryShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(0.0),
  ),
  side: BorderSide(
    color: kBlack,
    width: 4.0,
  ),
);

const kRollHistoryContentDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(
      color: kBlack,
      width: 4.0,
    ),
    bottom: BorderSide(
      color: kBlack,
      width: 4.0,
    ),
  ),
);

const kRollHistoryContentItemTextStyle = TextStyle(
  letterSpacing: 2.0,
  fontWeight: FontWeight.bold,
  fontSize: 22.6274,
  color: kBlack,
);

const kSumTextStyle = TextStyle(
  letterSpacing: 2.0,
  fontWeight: FontWeight.bold,
  fontSize: 22.6274,
  color: kBlack,
);

const kBoardPadding = EdgeInsets.only(
  top: 16.0,
  left: 16.0,
  right: 66.0,
  bottom: 66.0,
);
