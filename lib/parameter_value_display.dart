import 'package:flutter/material.dart';

class ParameterValueDisplay extends StatelessWidget {

  ParameterValueDisplay(this.value, this.color, {this.width = 60});

  final double value; 
  final Color color;
  final double width ;
  
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

  ParameterValueDisplayInt(this.value, this.color, {this.width = 45});

  final int value; 
  final Color color;
  final double width;
  
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
