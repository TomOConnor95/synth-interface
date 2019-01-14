import 'package:flutter/material.dart';
import './parameter_value_display.dart';
import './knob.dart';

class AmpFreqKnobs extends StatefulWidget {

  double ampValue; 
  double ampMin;
  double ampMax;
  Function(double) ampCallback;

  int freqValue; 
  int freqMin;
  int freqMax;
  Function(int) freqCallback;

  Color color;
  
  String label;

  AmpFreqKnobs({
    this.ampValue,
    this.ampMin,
    this.ampMax,
    this.ampCallback,
    this.freqValue,
    this.freqMin,
    this.freqMax,
    this.freqCallback,
    this.color,
    this.label,
  });

  @override
  _AmpFreqKnobsState createState() => new _AmpFreqKnobsState();
}

class _AmpFreqKnobsState extends State<AmpFreqKnobs>{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: widget.color, width: 1.5),
        borderRadius: BorderRadius.all(
            Radius.circular(8.0) //                 <--- border radius here
        ),
        // color: Colors.grey[200],
      ),
      width: 170,
      child: Column(
        children: <Widget>[
          Text(widget.label,
            style: TextStyle(
              color: widget.color,
              fontSize: 20,
            ),
          ),
          Container(
            height: 1.0,
            width: 200.0,
            color: widget.color,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Amount',
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 20,
                    ),
                  ),
                  Knob(
                    value: widget.ampValue,
                    color: widget.color,
                    onChanged:(value){widget.ampCallback(value);},
                    min: widget.ampMin,
                    max: widget.ampMax,
                    size: 50
                  ),
                  ParameterValueDisplay(widget.ampValue, widget.color)
                ],
              ),
              Column(
                children: <Widget>[
                  Text('Freq',
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 20,
                    ),
                  ),
                  KnobInt(
                    value: widget.freqValue,
                    color: widget.color,
                    onChanged:(value){ widget.freqCallback(value);},
                    min: widget.freqMin,
                    max: widget.freqMax,
                    size: 50
                  ),
                  ParameterValueDisplayInt(widget.freqValue, widget.color)
                ]
              ),
            ],
          ),
        ]
      ),
    );
      
      
    //   ListTile(
    //   contentPadding: EdgeInsets.only(left: 16),
    //   dense: true,
    //   leading: Text(
    //     widget.label,
    //     style: TextStyle(
    //       color: widget.color,
    //       fontSize: 20,
    //     ),
    //   ),
    //   title: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[ 
    //       Knob(
    //         color: widget.color,
    //         min: widget.min,
    //         max: widget.max,
    //         size: 40,
    //         onChanged: (value) => widget.callback(value),
    //         value: widget.value,
    //       ),
    //       ParameterValueDisplay(widget.value, widget.color, width: 50),
    //     ]
    //   ),
    // );
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
