// StatelessWidget representing the main screen of the app.
import 'package:dot_dice_lite/presentation/widgets/dice_view.dart';
import 'package:flutter/material.dart';

class DicePage extends StatelessWidget {
  const DicePage({Key? key}) : super(key: key);
  // Renders the Scaffold with a background color and an app bar. It includes
  // the `DiceView` widget to display the UI elements related to rolling dice.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFabd1c6),
      appBar: AppBar(toolbarHeight: 0),
      body: const DiceView(),
    );
  }
}
