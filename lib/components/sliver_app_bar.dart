import 'dart:io';
import 'dart:math';

import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

import 'components.dart';

typedef _ChildBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

/// A customised [SliverPersistentHeader] that acts as a [SliverAppBar].
/// This bar is typically positioned at the top of a screen to
/// facilitate navigation and indicate its title.
class LUSliverAppBar extends StatelessWidget {
  static const double _expandedHeight = 150.0;
  static const double _collapsedHeight = 120.0;
  static const int _animationMiliDuration = 120;

  const LUSliverAppBar({
    Key key,
    this.padding = const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
    this.backgroundColor,
    this.height = 200.0,
    this.title,
    this.tint,
    this.children,
    this.actionBackgroundColor,
    this.onNavigationButtonPressed,
    this.trailingButton,
  }) : super(key: key);

  final String title;
  final Color tint;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final double height;
  final List<Widget> children;
  final Color actionBackgroundColor;
  final Function onNavigationButtonPressed;
  final LUIconButton trailingButton;

  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
        floating: true,
        delegate: _SliverAppBarDelegate(
            expandedHeight: _expandedHeight,
            collapsedHeight: _collapsedHeight,
            builder: (BuildContext context, double shrinkOffset,
                bool overlapsContent) {
              final theme = Theme.of(context);
              return AnimatedContainer(
                height: height,
                duration: Duration(milliseconds: _animationMiliDuration),
                decoration: BoxDecoration(
                  color: backgroundColor ?? theme.appBarTheme.color,
                  boxShadow: overlapsContent
                      ? <BoxShadow>[
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 8.0,
                              offset: Offset(0.0, 0.75))
                        ]
                      : null,
                ),
                child: Padding(
                  padding: padding,
                  child: SafeArea(
                    bottom: false,
                    child: Row(
                        mainAxisAlignment: title != null
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children ??
                            <Widget>[
                              LUIconButton(
                                icon: Platform.isIOS
                                    ? Icons.arrow_back_ios
                                    : Icons.arrow_back,
                                onPressed: onNavigationButtonPressed,
                                tint: tint ?? theme.primaryColor,
                                backgroundColor: actionBackgroundColor ??
                                    theme.backgroundColor,
                              ),
                              if (_hasTitle)
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    title,
                                    style: Styles.topBarTitle
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                              Spacer(),
                              if (_hasTrailingButton) trailingButton
                            ]),
                  ),
                ),
              );
            }),
      );

  bool get _hasTrailingButton => trailingButton != null;

  bool get _hasTitle => title != null;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  const _SliverAppBarDelegate(
      {@required this.expandedHeight,
      @required this.collapsedHeight,
      @required this.builder})
      : assert(expandedHeight != null),
        assert(collapsedHeight != null),
        assert(builder != null);

  final double expandedHeight;
  final double collapsedHeight;
  final _ChildBuilder builder;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      builder(context, shrinkOffset, overlapsContent);

  @override
  double get minExtent => collapsedHeight;

  @override
  double get maxExtent => max(expandedHeight, minExtent);

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return expandedHeight != oldDelegate.expandedHeight ||
        collapsedHeight != oldDelegate.collapsedHeight;
  }
}
