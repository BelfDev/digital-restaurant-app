import 'package:dr_app/components/error_placeholder.dart';
import 'package:dr_app/components/loading_placeholder.dart';
import 'package:flutter/material.dart';

typedef Widget ContentBuilder();

class LULoadableContent extends StatelessWidget {
  final double height, width;
  final bool isSuccess, isLoading, isError;
  final ContentBuilder contentBuilder;

  const LULoadableContent({
    Key key,
    @required this.height,
    this.width = double.infinity,
    @required this.contentBuilder,
    @required this.isSuccess,
    @required this.isLoading,
    @required this.isError,
  })  : assert(height != null),
        assert(contentBuilder != null),
        assert(isSuccess != null && isLoading != null && isError != null),
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
    } else if (isError) {
      return LUErrorPlaceholder();
    } else if (isSuccess) {
      return contentBuilder();
    }
    throw Exception('Loadable content must return some widget');
  }
}
