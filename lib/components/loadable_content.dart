import 'package:dr_app/components/loading_placeholder.dart';
import 'package:flutter/material.dart';

class LULoadableContent extends StatelessWidget {
  final double height, width;
  final bool isLoading, isError;
  final Widget contentWidget;

  const LULoadableContent({
    Key key,
    @required this.height,
    this.width = double.infinity,
    @required this.contentWidget,
    @required this.isLoading,
    @required this.isError,
  })  : assert(height != null),
        assert(contentWidget != null),
        assert(isLoading != null && isError != null),
        assert(isLoading != isError),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 240),
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    if (isLoading) {
      return LULoadingPlaceholder(
        height: height,
        width: width,
      );
    } else if (!isLoading && !isError) {
      return contentWidget;
    } else if (isError) {
      return Text('Error');
    }
    throw Exception('Loadable content must return some widget');
  }
}
