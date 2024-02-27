// StatelessWidget representing the UI view for rolling dice.
import 'package:dot_dice_lite/presentation/constants/styles.dart';
import 'package:dot_dice_lite/presentation/viewmodels/dice_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiceView extends StatelessWidget {
  const DiceView({Key? key}) : super(key: key);
  // Displays the UI elements for rolling dice, such as dice images and
  // buttons. It interacts with the `DiceViewModel` to handle user actions.
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DiceViewModel>(context);

    return Container(
      padding: const EdgeInsets.all(0.0),
      color: kWhite,
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
                  'SUM: ${viewModel.sum.toString()} ',
                  style: kSumTextStyle,
                ),
                GestureDetector(
                  onTapDown: (_) {
                    viewModel.setHistoryButtonPressed(true);
                  },
                  onTapCancel: () {
                    viewModel.setHistoryButtonPressed(false);
                  },
                  onTapUp: (_) {
                    viewModel.setHistoryButtonPressed(true);
                    viewModel.showHistoryPopup(context);
                  },
                  child: Container(
                    color: kWhite,
                    height: 64,
                    child: AspectRatio(
                      aspectRatio: 2.0 / 1.0,
                      child: viewModel.isHistoryButtonPressed
                          ? Image.asset(
                              'assets/images/history-pressed.png',
                            )
                          : Image.asset(
                              'assets/images/history-unpressed.png',
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
                      padding: kBoardPadding,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double stackWidth = constraints.maxWidth;
                          double stackHeight = constraints.maxHeight;
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: viewModel.left1 * stackWidth,
                                top: viewModel.top1 * stackHeight,
                                child: Transform.rotate(
                                  angle: viewModel.rotation1,
                                  child: Image.asset(
                                    "assets/images/d6_${viewModel.dice1}.png",
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: viewModel.left2 * stackWidth,
                                top: viewModel.top2 * stackHeight,
                                child: Transform.rotate(
                                  angle: viewModel.rotation2,
                                  child: Image.asset(
                                    "assets/images/d6_${viewModel.dice2}.png",
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
                    viewModel.setRollButtonPressed(true);
                  },
                  onTapCancel: () {
                    viewModel.setRollButtonPressed(false);
                  },
                  onTapUp: (_) {
                    viewModel.setRollButtonPressed(false);
                    viewModel.roll();
                  },
                  child: AspectRatio(
                    aspectRatio: 3.0 / 1.0,
                    child: viewModel.isRollButtonPressed
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
