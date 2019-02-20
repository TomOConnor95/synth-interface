import 'package:flutter/material.dart';
import './parameter_value_display.dart';
import './knob.dart';

class KnobTile extends StatefulWidget {

  final double value; 
  final double min;
  final double max;

  final Color color;
  final Function(double) callback;
  final String label;

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

  final int value; 
  final int min;
  final int max;

  final Color color;
  final Function(int) callback;
  final String label;

  KnobTileInt({this.value, this.min, this.max, this.color, this.callback, this.label});

  @override
  _KnobTileIntState createState() => new _KnobTileIntState();
}

class _KnobTileIntState extends State<KnobTileInt>{
  @override
  Widget build(BuildContext context) {
      return ListTile(
      // contentPadding: EdgeInsets.only(left: 16),
      dense: true,
      leading: Text(
        widget.label,
        style: TextStyle(
        color: widget.color,
        fontSize: 20,
        ),
      ),
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          KnobInt(
            color: widget.color,
            min: 1,
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
