part of 'outlet_bloc.dart';

@immutable
abstract class OutletEvent extends Equatable {
  const OutletEvent();

  @override
  List<Object> get props => [];
}

class OutletProductsRequested extends OutletEvent {
  final int outletId;

  const OutletProductsRequested({
    @required this.outletId,
  }) : assert(outletId != null);

  @override
  List<Object> get props => [outletId];
}

class OutletsRequested extends OutletEvent {
  final String cuisine;

  const OutletsRequested({this.cuisine});

  @override
  List<Object> get props => [cuisine];
}
