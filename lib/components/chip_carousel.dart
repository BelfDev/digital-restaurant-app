import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/data/models/chip_item.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

import 'carousel.dart';

class LUChipCarousel extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final ValueChanged<int> onSelected;
  final List<ChipItem> items;

  const LUChipCarousel(
      {Key key,
      this.padding = const EdgeInsets.only(left: 16.0, right: 16.0),
      @required this.onSelected,
      this.items})
      : super(key: key);

  @override
  _LUChipCarouselState createState() => _LUChipCarouselState();
}

class _LUChipCarouselState extends State<LUChipCarousel> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return LUCarousel(
      height: Styles.chipCarouselHeight,
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      items: widget.items
          .map((ChipItem item) => ChoiceChip(
                elevation: 0.0,
                pressElevation: 4.0,
                backgroundColor: LUColors.smoothWhite,
                selectedColor: LUTheme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: LUTheme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                label: Text(item.text?.toUpperCase(),
                    style: _value == widget.items.indexOf(item)
                        ? Styles.chipText
                        : Styles.chipText
                            .copyWith(color: LUTheme.of(context).primaryColor)),
                selected: _value == widget.items.indexOf(item),
                onSelected: (bool selected) {
                  final index = widget.items.indexOf(item);
                  setState(() {
                    if (_value != index) {
                      _value = selected ? index : null;
                    }
                  });
                  widget.onSelected(index);
                },
              ))
          .toList(),
    );
  }
}
