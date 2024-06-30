
// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ColorChangingButton extends StatefulWidget {
  final Function(int) tapSaveResult;
  final Function() tap;
  final int initialState;
  final int Function(int) onChangeColor;
  final String text;
  final bool _showAnswers = false;

  ColorChangingButton(
      {required this.tapSaveResult,
      required this.tap,
      this.initialState = 1,
      required this.onChangeColor,
      required this.text,
      required bool showAnswers})
      : super();

  @override
  _ColorChangingButtonState createState() => _ColorChangingButtonState();
}

class _ColorChangingButtonState extends State<ColorChangingButton> {
  late int currentState;

  @override
  void initState() {
    super.initState();
    currentState = widget.initialState;
  }

  void validateAndChangeColor() {
    setState(() {
      if (!widget._showAnswers) {
        widget.tapSaveResult(currentState);
        currentState = widget.onChangeColor(currentState);
      } else {
        currentState = widget.initialState;
      }

      widget.tap();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget._showAnswers) {
      widget.tapSaveResult(currentState);
      currentState = widget.onChangeColor(currentState);
    } else {
      widget.tapSaveResult(currentState);
      currentState = widget.initialState;
    }
    Color buttonColor = Colors.grey;

    switch (currentState) {
      case 1:
        buttonColor = Colors.cyan;
        break;
      case 2:
        buttonColor = Colors.green;
        break;
      case 3:
        buttonColor = Colors.red;
        break;
    }

    return GestureDetector(
      onTap: validateAndChangeColor,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
