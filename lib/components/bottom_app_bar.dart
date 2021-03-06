import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/navigation/tab_data.dart';
import 'package:flutter/material.dart';

/// A custom [BottomAppBar] that emulates the appearance of a [BottomNavigationBar]
/// and adds a notch to host a centered [FloatingActionButton].
class LUBottomAppBar extends StatefulWidget {
  final List<TabData> tabs;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color unselectedColor;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;
  final double elevation;
  final double notchMargin;

  LUBottomAppBar(
      {@required this.tabs,
      this.centerItemText,
      this.height = 56.0,
      this.iconSize,
      this.backgroundColor,
      this.unselectedColor,
      this.selectedColor,
      this.notchedShape,
      this.onTabSelected,
      this.elevation,
      this.notchMargin = 8.0});

  @override
  _LUBottomAppBarState createState() => _LUBottomAppBarState();
}

class _LUBottomAppBarState extends State<LUBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = widget.tabs
        .map((tab) => _buildTabItem(tab: tab, onPressed: _updateIndex))
        .toList();
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      color:
          widget.backgroundColor ?? LUTheme.of(context).bottomAppBarTheme.color,
      shape: LUTheme.of(context).bottomAppBarTheme.shape,
      notchMargin: widget.notchMargin,
      elevation:
          widget.elevation ?? LUTheme.of(context).bottomAppBarTheme.elevation,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize ?? LUTheme.bottomBarIconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.unselectedColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    TabData tab,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == tab.index
        ? (widget.selectedColor ?? LUTheme.of(context).primaryColor)
        : (widget.unselectedColor ?? LUTheme.of(context).unselectedWidgetColor);
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: () => onPressed(tab.index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(tab.icon,
                    color: color,
                    size: widget.iconSize ?? LUTheme.bottomBarIconSize),
                SizedBox(height: 2),
                Text(
                  tab.title,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
