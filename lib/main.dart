import 'dart:math';
import 'package:dot_dice_lite/utilities/log.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DotDiceLite());
}

class DotDiceLite extends StatelessWidget {
  const DotDiceLite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dot Dice lite',
      theme: ThemeData(
        fontFamily: 'Redaction20',
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFabd1c6),
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: const DicePage(),
      ),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({key}) : super(key: key);

  @override
  DicePageState createState() => DicePageState();
}

class DicePageState extends State<DicePage> {
  bool isRollButtonPressed = false;
  bool isHistoryButtonPressed = false;
  bool isCloseButtonPressed = false;
  List<Log> diceRollHistory = [];
  int dice1 = 1, dice2 = 1, sum = 2;
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
          firstImage: Image.asset(
            "assets/images/d6_$dice1.png",
            width: 30.0,
            height: 30.0,
          ),
          secondImage: Image.asset(
            "assets/images/d6_$dice2.png",
            width: 30.0,
            height: 30.0,
          ),
          sum: sum),
    );
  }

  void _showHistoryPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Roll History',
              style: TextStyle(
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
                fontSize: 26.9087,
                color: Color(0xFF001E1D),
              ),
            ),
          ),
          backgroundColor: const Color(0xFFABD1C6),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0.0),
            ),
            side: BorderSide(
              color: Color(0xFF001E1D),
              width: 4.0,
            ),
          ),
          content: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFF001E1D),
                  width: 4.0,
                ),
                bottom: BorderSide(
                  color: Color(0xFF001E1D),
                  width: 4.0,
                ),
              ),
            ),
            child: SizedBox(
              width: double.maxFinite,
              height: 300.0,
              child: diceRollHistory.isNotEmpty
                  ? RawScrollbar(
                      thumbVisibility: true,
                      thumbColor: const Color(0xFF001E1D),
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
                                    child: roll.firstImage,
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 8.0),
                                    child: roll.secondImage,
                                  ),
                                ),
                                Text(
                                  '  ${roll.sum}',
                                  style: const TextStyle(
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.6274,
                                    color: Color(0xFF001E1D),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text(
                        'No dice roll history yet. Cast your dice with the "Roll Dice" button!\n— Ori',
                        style: TextStyle(
                          fontSize: 22.6274,
                          color: Color(0xFF001E1D),
                        ),
                      ),
                    ),
            ),
          ),
          actions: [
            Center(
              child: GestureDetector(
                onTapDown: (_) {
                  setState(
                    () {
                      isCloseButtonPressed = true;
                    },
                  );
                },
                onTapCancel: () {
                  setState(
                    () {
                      isCloseButtonPressed = true;
                    },
                  );
                },
                onTapUp: (_) {
                  Navigator.of(context).pop();
                  setState(
                    () {
                      isHistoryButtonPressed = false;
                    },
                  );
                },
                child: SizedBox(
                  height: 48,
                  child: AspectRatio(
                    aspectRatio: 1.0 / 1.0,
                    child: Image.asset(
                      'assets/images/close-unpressed.png',
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      color: const Color(0xFFABD1C6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SUM: $sum ',
                  style: const TextStyle(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.6274,
                    color: Color(0xFF001E1D),
                  ),
                ),
                GestureDetector(
                  onTapDown: (_) {
                    setState(
                      () {
                        isHistoryButtonPressed = true;
                      },
                    );
                  },
                  onTapCancel: () {
                    setState(
                      () {
                        isHistoryButtonPressed = false;
                      },
                    );
                  },
                  onTapUp: (_) {
                    setState(
                      () {
                        isCloseButtonPressed = false;
                      },
                    );
                    _showHistoryPopup(context);
                  },
                  child: SizedBox(
                    height: 64,
                    child: Container(
                      color: const Color(0xFFABD1C6),
                      child: AspectRatio(
                        aspectRatio: 2.0 / 1.0,
                        child: isHistoryButtonPressed
                            ? Image.asset(
                                'assets/images/history-pressed.png',
                              )
                            : Image.asset(
                                'assets/images/history-unpressed.png',
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              alignment: Alignment.topCenter,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/board_lite.png',
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        left: 16.0,
                        right: 66.0,
                        bottom: 66.0,
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double stackWidth = constraints.maxWidth;
                          double stackHeight = constraints.maxHeight;

                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: left1 * stackWidth,
                                top: top1 * stackHeight,
                                child: Transform.rotate(
                                  angle: rotation1,
                                  child: Image.asset(
                                    "assets/images/d6_$dice1.png",
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: left2 * stackWidth,
                                top: top2 * stackHeight,
                                child: Transform.rotate(
                                  angle: rotation2,
                                  child: Image.asset(
                                    "assets/images/d6_$dice2.png",
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 96,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Center(
                child: GestureDetector(
                  onTapDown: (_) {
                    setState(
                      () {
                        isRollButtonPressed = true;
                      },
                    );
                  },
                  onTapCancel: () {
                    setState(
                      () {
                        isRollButtonPressed = false;
                      },
                    );
                  },
                  onTapUp: (_) {
                    setState(
                      () {
                        isRollButtonPressed = false;
                        roll();
                      },
                    );
                  },
                  child: AspectRatio(
                    aspectRatio: 3.0 / 1.0,
                    child: isRollButtonPressed
                        ? Image.asset('assets/images/roll-pressed.png')
                        : Image.asset('assets/images/roll-unpressed.png'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
