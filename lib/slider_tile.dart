import 'package:flutter/material.dart';
import './parameter_value_display.dart';
class SliderTile extends StatefulWidget {

  double sliderValue; 
  Color color;
  Function(num) callback;
  String label;

  SliderTile(this.sliderValue, this.color, this.callback, this.label);

  @override
  _SliderTileState createState() => new _SliderTileState();
}

class _SliderTileState extends State<SliderTile>{
  @override
  Widget build(BuildContext context) {
      return ListTile(
      contentPadding: EdgeInsets.only(left: 16),
      dense: true,
      leading: Text(
        widget.label,
        style: TextStyle(
        color: widget.color,
        fontSize: 20,
        ),
      ),
      trailing: ParameterValueDisplay(widget.sliderValue, widget.color),
      title: Slider(
        activeColor: widget.color,
        min: 0.0,
        max: 1.0,
        onChanged: (value) => widget.callback(value),
        value: widget.sliderValue,
      ),
    );
  }
}

class SliderTileInt extends StatefulWidget {

  int sliderValue; 
  Color color;
  Function(num) callback;
  String label;

  SliderTileInt(this.sliderValue, this.color, this.callback, this.label);

  @override
  _SliderTileIntState createState() => new _SliderTileIntState();
}

class _SliderTileIntState extends State<SliderTileInt>{
  @override
  Widget build(BuildContext context) {
      return ListTile(
      contentPadding: EdgeInsets.only(left: 16),
      dense: true,
      leading: Text(
        widget.label,
        style: TextStyle(
        color: widget.color,
        fontSize: 20,
        ),
      ),
      trailing: ParameterValueDisplayInt(widget.sliderValue, widget.color, width: 48),
      title: Slider(
        activeColor: widget.color,
        min: 0,
        max: 10,
        divisions: 10,
        onChanged: (value) => widget.callback(value.toInt()),
        value: widget.sliderValue.toDouble(),
      ),
    );
  }
}
