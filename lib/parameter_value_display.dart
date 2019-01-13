import 'package:flutter/material.dart';

class ParameterValueDisplay extends StatelessWidget {

  ParameterValueDisplay(this.value, this.color, {this.width});

  final double value; 
  final Color color;
  double width = 60;
  
  @override
  Widget build(BuildContext context){
    return Container(
      width: width,
      child: Text(
        '${value.toStringAsFixed(2)}',
        style: TextStyle(
          color: color,
          fontSize: 22,
        ),
      )
    );
  }
}

class ParameterValueDisplayInt extends StatelessWidget {

  ParameterValueDisplayInt(this.value, this.color, {this.width});

  final int value; 
  final Color color;
  double width = 45;
  
  @override
  Widget build(BuildContext context){
    return Container(
      width: width,
      child: Text(
        value.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 22,
        ),
      )
    );
  }
}
