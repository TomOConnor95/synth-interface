import 'package:flutter/material.dart';
import './parameter_value_display.dart';
import './knob.dart';

class KnobTile extends StatefulWidget {

  double value; 
  double min;
  double max;

  Color color;
  Function(num) callback;
  String label;

  KnobTile({this.value, this.min, this.max, this.color, this.callback, this.label});

  @override
  _KnobTileState createState() => new _KnobTileState();
}

class _KnobTileState extends State<KnobTile>{
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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[ 
          Knob(
            color: widget.color,
            min: widget.min,
            max: widget.max,
            size: 40,
            onChanged: (value) => widget.callback(value),
            value: widget.value,
          ),
          ParameterValueDisplay(widget.value, widget.color, width: 50),
        ]
      ),
    );
  }
}

class KnobTileInt extends StatefulWidget {

  int value; 
  int min;
  int max;

  Color color;
  Function(num) callback;
  String label;

  KnobTileInt({this.value, this.min, this.max, this.color, this.callback, this.label});

  @override
  _KnobTileIntState createState() => new _KnobTileIntState();
}

class _KnobTileIntState extends State<KnobTileInt>{
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
      title: Column(
        children: <Widget>[
          KnobInt(
            color: widget.color,
            min: 0,
            max: 10,
            size: 40,
            onChanged: (value) => widget.callback(value.toInt()),
            value: widget.value,
          ),
          ParameterValueDisplayInt(widget.value, widget.color, width: 30),
        ],
      ),
    );
  }
}
