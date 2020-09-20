import 'package:dr_app/components/components.dart';
import 'package:dr_app/components/information_tile.dart';
import 'package:dr_app/components/section.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/configs/theme.dart';
import 'package:flutter/material.dart';

/// The AboutVersionScreen displays information about the current
/// App version such as Author, Version number, and Libraries used.
class AboutVersionScreen extends StatelessWidget {
  static const id = 'about_version_screen';

  static const openSourceLibs = [
    'cupertino_icons: ^0.1.3',
    'flutter_vector_icons: ^0.2.1',
    'smooth_star_rating: 1.1.1',
    'flutter_swiper: ^1.1.6',
    'flutter_page_indicator: ^0.0.3',
    'slide_to_confirm: ^0.0.6',
    'credit_card_slider: ^1.0.1',
    'qr_code_scanner',
    'validators: ^2.0.0+1',
    'bloc: ^6.0.0',
    'flutter_bloc: ^6.0.0',
    'meta: ^1.1.8',
    'equatable: ^1.2.3',
    'json_annotation: ^3.0.1',
    'http: ^0.12.2',
    'http_interceptor: ^0.3.2',
    'shared_preferences: ^0.5.10',
    'test: 1.15.2',
    'mockito: ^4.1.1',
    'bloc_test: ^7.0.4',
    'build_runner: ^1.10.1',
    'json_serializable: ^3.3.0',
  ];

  @override
  Widget build(BuildContext context) {
    final titlePadding = EdgeInsets.only(left: 4.0, bottom: 8.0);

    List<Widget> getLibraryTiles() {
      return List.generate(
          openSourceLibs.length,
          (index) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: LUInformationTile(
                  text: openSourceLibs[index],
                ),
              ));
    }

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
                onNavigationButtonPressed: () => Navigator.of(context).pop(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    LUSection(
                        title: 'Version',
                        titlePadding: titlePadding,
                        builder: (_) => LUInformationTile(text: '1.0.0')),
                    LUSection(
                        title: 'Author',
                        titlePadding: titlePadding,
                        builder: (_) =>
                            LUInformationTile(text: 'Pedro Belfort')),
                    LUSection(
                      title: 'Open Source Libraries',
                      titlePadding: titlePadding,
                      builder: (_) => LUList(
                        padding: const EdgeInsets.only(bottom: 160),
                        nested: true,
                        space: 2,
                        items: getLibraryTiles(),
                      ),
                    ),
                  ],
                ),
              )
            ])));
  }
}
