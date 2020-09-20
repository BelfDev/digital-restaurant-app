import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/repositories/order_repository.dart';
import 'package:dr_app/data/repositories/payment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

/// Business logic component for the Checkout
/// This class maps incoming [CheckOutEvent] events into [CheckOutState] streams.
class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  static const id = 'checkout_bloc';

  final OrderRepository orderRepository;
  final PaymentRepository paymentRepository;

  CheckOutBloc({
    @required this.orderRepository,
    @required this.paymentRepository,
  })  : assert(orderRepository != null),
        assert(paymentRepository != null),
        super(CheckOutState.initial(null));

  @override
  Stream<CheckOutState> mapEventToState(
    CheckOutEvent event,
  ) async* {
    switch (event.runtimeType) {
      case AddCartToOrderRequested:
        yield* _mapAddCartToOrderRequestedToState(event);
        break;
      case ClearOrderRequested:
        yield* _mapClearOrderRequestedToState(event);
        break;
      case MakePaymentRequested:
        yield* _mapMakePaymentRequestedToState(event);
        break;
    }
  }

  Stream<CheckOutState> _mapAddCartToOrderRequestedToState(
      AddCartToOrderRequested event) async* {
    // Loading
    yield CheckOutState.loading(state.order);
    try {
      // Success
      final order = await orderRepository.addCart(
        cartId: event.cartId,
      );
      yield CheckOutState.success(order);
    } catch (error) {
      // Error
      yield CheckOutState.error(state.order);
    }
  }

  Stream<CheckOutState> _mapClearOrderRequestedToState(
      ClearOrderRequested event) async* {
    // Loading
    yield CheckOutState.loading(state.order);
    try {
      // Success
      await orderRepository.clearOrder();
      yield CheckOutState.success(null);
    } catch (error) {
      // Error
      yield CheckOutState.error(state.order);
    }
  }

  Stream<CheckOutState> _mapMakePaymentRequestedToState(
      MakePaymentRequested event) async* {
    // Loading
    yield CheckOutState.loading(state.order);
    try {
      // Success
      await paymentRepository.createPayment(
        orderId: event.orderId,
        paymentMethodId: event.paymentMethodId,
      );
      await orderRepository.clearOrder();
      yield CheckOutState.success(null);
    } catch (error) {
      // Error
      yield CheckOutState.error(state.order);
    }
  }

  @override
  // ignore: must_call_super, missing_return
  Future<void> close() {
    // return super.close();
  }
}
