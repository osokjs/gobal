import 'package:flutter/material.dart';

class CurrentPosition extends StatefulWidget {
  const CurrentPosition({Key? key}) : super(key: key);

  @override
  _CurrentPositionState createState() => _CurrentPositionState();
}

class _CurrentPositionState extends State<CurrentPosition> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text('current position'),
    );
  }
}
