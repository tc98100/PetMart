import 'package:cupertino_store/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SegmentedControl extends StatefulWidget {
  final Function(int) callBack;
  int initialValue;
  SegmentedControl(this.callBack, this.initialValue);

  @override
  _SegmentedControlState createState() => _SegmentedControlState(initialValue);
}

// Constants for `Pets` vs `Accessories` toggle
const PET_VALUE = 0;
const ACCESSORIES_VALUE = 1;

class _SegmentedControlState extends State<SegmentedControl> {
  _SegmentedControlState(this.initialValue);
  int initialValue;
  Function(int) callBack;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: CupertinoSlidingSegmentedControl(
            thumbColor: appTheme.primaryColor,
            groupValue: initialValue,
            children: const <int, Widget>{
              PET_VALUE: Text('Pets'),
              ACCESSORIES_VALUE: Text('Accessories'),
            },
            onValueChanged: (value) {
              setState(() {
                print((MediaQuery.of(context).size.height / 15 / 10).round());
                initialValue = value;
                widget.callBack(initialValue);
              });
            }),
      ),
    );
  }
}
