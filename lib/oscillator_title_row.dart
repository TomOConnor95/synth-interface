import 'package:flutter/material.dart';
import './color_picker_button.dart';

class OscillatorTitleRow extends StatelessWidget {

  OscillatorTitleRow({this.title, this.color, this.onColorChanged, this.onShufflePressed});

  final String title;
  final Color color;
  final ValueChanged<Color> onColorChanged;
  final Function() onShufflePressed;
  
  @override
  Widget build(BuildContext context){
    return Row(
      children: <Widget> [
        Text(
          title,
          style: TextStyle(
          color: color,
          fontSize: 22,
          ),
        ),
        ColorPickerButton(
          color: color,
          onColorChanged: onColorChanged,
        ),
        IconButton(
          icon: Icon(Icons.shuffle, size: 33),
          color: color,
          padding: EdgeInsets.all(0.0),
          onPressed: () => onShufflePressed(),
        ),
      ]
    );
  }
}
