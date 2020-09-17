import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/components/error_placeholder.dart';
import 'package:dr_app/components/loading_placeholder.dart';
import 'package:flutter/material.dart';

typedef Widget ContentBuilder();

class LULoadableContent extends StatelessWidget {
  final double height, width;
  final ContentStateStatus stateStatus;
  final ContentBuilder contentBuilder;

  const LULoadableContent({
    Key key,
    @required this.height,
    this.width = double.infinity,
    @required this.contentBuilder,
    @required this.stateStatus,
  })  : assert(height != null),
        assert(contentBuilder != null),
        assert(stateStatus != null),
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

  bool get isLoading =>
      stateStatus == ContentStateStatus.loadInProgress ||
      stateStatus == ContentStateStatus.initial;

  bool get isError => stateStatus == ContentStateStatus.loadFailure;

  bool get isSuccess => stateStatus == ContentStateStatus.loadSuccess;
}
