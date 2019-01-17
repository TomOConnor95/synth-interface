import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerButton extends StatelessWidget {

  ColorPickerButton({this.color, this.onColorChanged});

  final Color color;
  final ValueChanged<Color> onColorChanged;
  
  @override
  Widget build(BuildContext context){
    return IconButton(
      icon: Icon(Icons.color_lens, size: 33),
      color: color,
      padding: EdgeInsets.all(0.0),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.all(0.0),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: color,
                  onColorChanged: onColorChanged,
                  colorPickerWidth: 1000.0,
                  pickerAreaHeightPercent: 0.7,
                  enableAlpha: false,
                  enableLabel: false,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
