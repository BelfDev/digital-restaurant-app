import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';

class LUCounter extends StatefulWidget {
  @override
  _LUCounterState createState() => _LUCounterState();
}

class _LUCounterState extends State<LUCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      decoration: BoxDecoration(
          color: LUColors.smoothGray,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildCounterButton(Icons.remove, () {}),
          _buildDivider(),
          Text(
            '2',
            style: TextStyle(
                fontSize: 22,
                color: LUColors.darkBlue,
                fontWeight: FontWeight.bold),
          ),
          _buildDivider(),
          _buildCounterButton(Icons.add, () {}),
        ],
      ),
    );
  }

  Widget _buildCounterButton(IconData icon, Function onPressed) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          onTap: onPressed,
          child: Icon(
            icon,
            color: LUColors.darkBlue,
          ),
        ),
      );

  Widget _buildDivider() => VerticalDivider(
        width: 4,
        indent: 4,
        endIndent: 4,
        color: const Color(0X443C3C43),
      );
}
