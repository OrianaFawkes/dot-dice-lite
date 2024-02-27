// Manages the state and behavior related to the dice rolling functionality
// in Dot Dice.
import 'dart:math';
import 'package:dot_dice_lite/domain/entities/log.dart';
import 'package:dot_dice_lite/presentation/constants/styles.dart';
import 'package:flutter/material.dart';

class DiceViewModel extends ChangeNotifier {
  bool isRollButtonPressed = false;
  bool isHistoryButtonPressed = false;
  bool isCloseButtonPressed = false;

  List<Log> diceRollHistory = [];

  int dice1 = 1;
  int dice2 = 1;
  int sum = 2;

  double rotation1 = Random().nextDouble() * 360.0 * (pi / 180),
      rotation2 = Random().nextDouble() * 360.0 * (pi / 180),
      top1 = Random().nextDouble(),
      top2 = Random().nextDouble(),
      left1 = Random().nextDouble(),
      left2 = Random().nextDouble();

  void roll() {
    dice1 = Random().nextInt(6) + 1;
    dice2 = Random().nextInt(6) + 1;
    sum = dice1 + dice2;

    rotation1 = Random().nextDouble() * 360.0 * (pi / 180);
    rotation2 = Random().nextDouble() * 360.0 * (pi / 180);

    double minSeparation = 0.1;

    top1 = Random().nextDouble();
    left1 = Random().nextDouble();

    do {
      top2 = Random().nextDouble();
      left2 = Random().nextDouble();
    } while ((top2 - top1).abs() < minSeparation ||
        (left2 - left1).abs() < minSeparation);

    diceRollHistory.add(
      Log(
          firstImage: 'assets/images/d6_$dice1.png',
          secondImage: 'assets/images/d6_$dice2.png',
          sum: sum),
    );
    notifyListeners();
  }

  void showHistoryPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: kRollHistoryTitle,
          backgroundColor: kWhite,
          shape: kRollHistoryShape,
          content: Container(
            decoration: kRollHistoryContentDecoration,
            child: SizedBox(
              width: double.maxFinite,
              height: 300.0,
              child: diceRollHistory.isNotEmpty
                  ? RawScrollbar(
                      thumbVisibility: true,
                      thumbColor: kBlack,
                      thickness: 5,
                      child: ListView.builder(
                        itemCount: diceRollHistory.length,
                        itemBuilder: (context, index) {
                          Log roll = diceRollHistory.reversed.toList()[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 8.0),
                                    child: Image.asset(
                                      roll.firstImage,
                                      width: 30.0,
                                      height: 30.0,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 8.0),
                                    child: Image.asset(
                                      roll.secondImage,
                                      width: 30.0,
                                      height: 30.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  '  ${roll.sum}',
                                  style: kRollHistoryContentItemTextStyle,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : kRollHistoryEmptyMessage,
            ),
          ),
          actions: [
            Center(
              child: GestureDetector(
                onTapDown: (_) {
                  setCloseButtonPressed(true);
                },
                onTapCancel: () {
                  setCloseButtonPressed(true);
                },
                onTapUp: (_) {
                  Navigator.of(context).pop();
                  setHistoryButtonPressed(false);
                },
                child: kRollHistoryCloseButton,
              ),
            ),
          ],
        );
      },
    );
  }

  void setHistoryButtonPressed(bool value) {
    isHistoryButtonPressed = value;
    notifyListeners();
  }

  void setRollButtonPressed(bool value) {
    isRollButtonPressed = value;
    notifyListeners();
  }

  void setCloseButtonPressed(bool value) {
    isCloseButtonPressed = value;
    notifyListeners();
  }
}
