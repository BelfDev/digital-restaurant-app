import 'package:dr_app/components/information_tile.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

/// The AboutVersionScreen displays information about the current
/// App version such as Author, Version number, and Libraries used.
class AboutVersionScreen extends StatelessWidget {
  static const id = 'about_version_screen';

  @override
  Widget build(BuildContext context) {
    return Container(
        color: LUTheme.of(context).backgroundColor,
        child: SafeArea(
            child: ListView(
                padding: EdgeInsets.zero,
                physics: ClampingScrollPhysics(),
                children: <Widget>[
              LUTopBar(
                title: 'About version',
                buttonBackgroundColor: LUTheme.of(context).primaryColor,
                tint: LUTheme.of(context).backgroundColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LUSection(
                    title: 'Version',
                    titlePadding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                    child: LUInformationTile(text: '0.0.1 | 32')),
              )
            ])));
  }
}
