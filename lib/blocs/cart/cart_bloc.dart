import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dr_app/blocs/blocs.dart';
import 'package:dr_app/blocs/checkout/checkout_bloc.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  static const id = 'cart_bloc';

  final HomeBloc homeBloc;
  final CartRepository cartRepository;
  final CheckOutBloc checkOutBloc;

  StreamSubscription _homeModeSubscription;
  StreamSubscription _checkOutSubscription;

  CartBloc({
    @required this.homeBloc,
    @required this.cartRepository,
    @required this.checkOutBloc,
  })  : assert(homeBloc != null),
        assert(cartRepository != null),
        assert(checkOutBloc != null),
        super(CartState.initial()) {
    _homeModeSubscription = homeBloc.listenHomeMode((event) {
      if (event.mode == HomeMode.checkedIn) {
        add(NewCartRequested(event.outletId));
      } else if (event.mode == HomeMode.checkedOut) {
        add(ClearCartRequested());
      }
    });

    _checkOutSubscription = checkOutBloc.listen((checkOutState) {
      final order = checkOutState.order;
      if (checkOutState.status == ContentStateStatus.loadSuccess &&
          order.carts.contains(this.state.cart)) {
        final outletId = this.state.outletId;
        this.add(NewCartRequested(outletId));
      }
    });
  }

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    switch (event.runtimeType) {
      case NewCartRequested:
        yield* _mapNewCartRequestedToState(event);
        break;
      case ClearCartRequested:
        yield* _mapClearCartRequestedToState(event);
        break;
      case AddToCartRequested:
        yield* _mapAddToCartRequestedToState(event);
        break;
      case CartRequested:
        yield* _mapCartRequestedToState(event);
        break;
      case RemoveCartItemRequested:
        yield* _mapRemoveCartItemRequestedToState(event);
        break;
    }
  }

  Stream<CartState> _mapNewCartRequestedToState(
    NewCartRequested event,
  ) async* {
    await cartRepository.clearCart();
    final cart = await cartRepository.createCart(outletId: event.outletId);
    yield state.copyWith(cart: cart, outletId: event.outletId);
  }

  Stream<CartState> _mapClearCartRequestedToState(
    ClearCartRequested event,
  ) async* {
    await cartRepository.clearCart();
    yield state.copyWith(outletId: null, cart: null);
  }

  Stream<CartState> _mapAddToCartRequestedToState(
    AddToCartRequested event,
  ) async* {
    final initializedState = await _initCartIfNeeded(state);
    // Loading
    yield initializedState.copyWith(
      status: ContentStateStatus.loadInProgress,
    );
    try {
      // Success
      final cart = await cartRepository.addCartItem(
          productId: event.productId, quantity: event.quantity);
      yield initializedState.copyWith(
        status: ContentStateStatus.loadSuccess,
        cart: cart,
      );
    } catch (error) {
      // Error
      yield initializedState.copyWith(
        status: ContentStateStatus.loadFailure,
      );
    }
  }

  Stream<CartState> _mapCartRequestedToState(
    CartRequested event,
  ) async* {
    final initializedState = await _initCartIfNeeded(state);
    // Loading
    yield initializedState.copyWith(
      status: ContentStateStatus.loadInProgress,
    );
    try {
      // Success
      final cart = await cartRepository.fetchCart();
      yield initializedState.copyWith(
        status: ContentStateStatus.loadSuccess,
        cart: cart,
      );
    } catch (error) {
      // Error
      yield initializedState.copyWith(
        status: ContentStateStatus.loadFailure,
      );
    }
  }

  Stream<CartState> _mapRemoveCartItemRequestedToState(
    RemoveCartItemRequested event,
  ) async* {
    final initializedState = await _initCartIfNeeded(state);
    // Loading
    yield initializedState.copyWith(
      status: ContentStateStatus.loadInProgress,
    );
    try {
      // Success
      await cartRepository.removeCartItem(productId: event.productId);
      final cart = await cartRepository.fetchCart();
      yield initializedState.copyWith(
        status: ContentStateStatus.loadSuccess,
        cart: cart,
      );
    } catch (error) {
      // Error
      yield initializedState.copyWith(
        status: ContentStateStatus.loadFailure,
      );
    }
  }

  Future<CartState> _initCartIfNeeded(
    CartState state,
  ) async {
    if (state.cart == null) {
      final cart = await cartRepository.fetchCart();
      return state.copyWith(cart: cart);
    }
    return state;
  }

  // TODO: Evaluate best moment to cancel subscriptions
  @override
  Future<void> close() {
    // _checkOutSubscription?.cancel();
    // _homeModeSubscription?.cancel();
    // return super.close();
  }
}
