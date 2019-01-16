import 'package:flutter/material.dart';
import './parameter_value_display.dart';
import './knob.dart';

class AmpFreqKnobs extends StatefulWidget {

  final double ampValue; 
  final double ampMin;
  final double ampMax;
  final Function(double) ampCallback;

  final int freqValue; 
  final int freqMin;
  final int freqMax;
  final Function(int) freqCallback;

  final Color color;
  
  final String label;

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
  }
}
