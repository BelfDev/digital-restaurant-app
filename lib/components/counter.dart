import 'package:dr_app/utils/colors.dart';
import 'package:flutter/material.dart';

class LUCounter extends StatefulWidget {
  final ValueChanged<int> onUpdate;
  final bool vertical;

  const LUCounter({Key key, @required this.onUpdate, this.vertical = false})
      : super(key: key);

  @override
  _LUCounterState createState() => _LUCounterState();
}

class _LUCounterState extends State<LUCounter> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return widget.vertical
        ? _buildVerticalCounter()
        : _buildHorizontalCounter();
  }

  Widget _buildCounterButton(IconData icon, Function onPressed) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          onTap: onPressed,
          child: SizedBox(
            width: widget.vertical ? 48 : 50,
            height: widget.vertical ? 54 : 40,
            child: Icon(
              icon,
              color: LUColors.darkBlue,
            ),
          ),
        ),
      );

  Widget _buildDivider() {
    return widget.vertical
        ? Divider(
            height: 4,
            indent: 4,
            endIndent: 4,
            color: const Color(0X443C3C43),
          )
        : VerticalDivider(
            width: 4,
            indent: 4,
            endIndent: 4,
            color: const Color(0X443C3C43),
          );
  }

  Widget _buildHorizontalCounter() => Container(
        height: 40,
        decoration: BoxDecoration(
            color: LUColors.smoothGray,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildCounterButton(Icons.remove, () {
              if (_counter - 1 >= 0) {
                setState(() => _counter--);
                widget.onUpdate(_counter);
              }
            }),
            _buildDivider(),
            SizedBox(
              width: 50,
              height: 40,
              child: Center(
                child: Text(
                  _counter.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: LUColors.darkBlue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            _buildDivider(),
            _buildCounterButton(Icons.add, () {
              setState(() => _counter++);
              widget.onUpdate(_counter);
            }),
          ],
        ),
      );

  Widget _buildVerticalCounter() => Container(
        width: 48,
        height: 112,
        decoration: BoxDecoration(
            color: LUColors.smoothGray,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildCounterButton(Icons.remove, () {
              if (_counter - 1 >= 0) {
                setState(() => _counter--);
                widget.onUpdate(_counter);
              }
            }),
            _buildDivider(),
            _buildCounterButton(Icons.add, () {
              setState(() => _counter++);
              widget.onUpdate(_counter);
            }),
          ],
        ),
      );
}
