import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/repositories/outlet_respository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'outlet_event.dart';
part 'outlet_state.dart';

/// Business logic component for the Outlet
/// This class maps incoming [OutletEvent] events into [OutletState] streams.
class OutletBloc extends Bloc<OutletEvent, OutletState> {
  static const id = 'outlet_bloc';

  final OutletRepository outletRepository;

  OutletBloc({
    @required this.outletRepository,
  })  : assert(outletRepository != null),
        super(OutletState.initial());

  @override
  Stream<OutletState> mapEventToState(
    OutletEvent event,
  ) async* {
    switch (event.runtimeType) {
      case OutletProductsRequested:
        yield* _mapOutletProductsRequestedToState(event);
        break;
      case OutletsRequested:
        yield* _mapOutletsRequestedToState(event);
        break;
    }
  }

  Stream<OutletState> _mapOutletProductsRequestedToState(
      OutletProductsRequested event) async* {
    yield OutletState.loading();
    try {
      final List<Product> products =
          await outletRepository.fetchAllOutletProducts(event.outletId);

      // Generate categories map
      final Map<Category, List<Product>> categoryMap =
          Map<Category, List<Product>>();
      products.forEach((product) {
        final productCategories = product.categories;
        productCategories.forEach((category) {
          if (!categoryMap.containsKey(category)) {
            categoryMap[category] = List<Product>();
          }
          categoryMap[category].add(product);
        });
      });

      // Return categoryMap
      yield OutletState.success(categoryMap, null);
    } catch (error) {
      yield OutletState.error();
    }
  }

  Stream<OutletState> _mapOutletsRequestedToState(
      OutletsRequested event) async* {
    yield OutletState.loading();
    try {
      final List<Outlet> outlets =
          await outletRepository.fetchAllOutlets(cuisine: event.cuisine);

      yield OutletState.success(null, outlets);
    } catch (error) {
      yield OutletState.error();
    }
  }

  @override
  // ignore: must_call_super, missing_return
  Future<void> close() {
    // return super.close();
  }
}
