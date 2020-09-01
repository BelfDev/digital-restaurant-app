import 'package:flutter/material.dart';

/// A [CustomScrollView] that lays out an [appBar] and a [body].
class LUScrollScaffold extends StatelessWidget {
  const LUScrollScaffold({
    Key key,
    @required this.appBar,
    @required this.body,
    this.header,
  })  : assert(appBar != null),
        assert(body != null),
        super(key: key);

  final WidgetBuilder appBar;
  final WidgetBuilder header;
  final WidgetBuilder body;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        appBar(context),
        if (_hasHeader) header(context),
        body(context)
      ],
    );
  }

  bool get _hasHeader => header != null;
}
