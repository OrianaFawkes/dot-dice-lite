// Made by Ori, 02-2024
// Entry point of the Flutter application.
import 'package:dot_dice_lite/presentation/pages/dice_page.dart';
import 'package:dot_dice_lite/presentation/viewmodels/dice_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const DotDiceLite());
}

class DotDiceLite extends StatelessWidget {
  const DotDiceLite({Key? key}) : super(key: key);
  // Initializes the app and sets up the `MaterialApp` with theme settings and
  // the home screen.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dot Dice lite',
      theme: ThemeData(fontFamily: 'Redaction20'),
      home: ChangeNotifierProvider(
        create: (context) => DiceViewModel(),
        child: const DicePage(),
      ),
    );
  }
}
