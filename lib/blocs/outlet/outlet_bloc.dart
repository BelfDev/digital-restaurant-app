import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/repositories/outlet_respository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'outlet_event.dart';
part 'outlet_state.dart';

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
      yield OutletState.success(categoryMap);
    } catch (error) {
      yield OutletState.error();
    }
  }

  @override
  Future<void> close() {
    // return super.close();
  }
}
