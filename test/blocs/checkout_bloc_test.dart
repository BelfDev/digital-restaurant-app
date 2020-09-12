import 'package:bloc_test/bloc_test.dart';
import 'package:dr_app/blocs/checkout/checkout_bloc.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/repositories/order_repository.dart';
import 'package:dr_app/data/repositories/payment_repository.dart';
import 'package:dr_app/services/api/network_exception.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// Mock objects
final Category _mockCategory = Category('TestCategory', null);
final Cuisine _mockCuisine = Cuisine(1, 'Italian', null);
final Location _mockLocation = Location('Glasgow');
final Product _mockProduct = Product(
    10, 'Test', 10, 'Description', 10, null, const [], [_mockCategory], 10);
final List<Product> _mockProductList = List.generate(
    3,
    (index) => Product(index, 'Test', 10, 'Description', 10, null, const [],
        [_mockCategory], 10));
final Outlet _mockOutlet =
    Outlet(1, 'Outlet 1', 4, 4, _mockCuisine, null, _mockLocation);
final Cart _mockCart = Cart(1, 200, CartStatus.NOT_ORDERED, _mockProductList);
final Order _mockOrder = Order(1, 200, OrderStatus.OPEN, [_mockCart]);

class MockOrderRepository extends Mock implements OrderRepository {}

class MockPaymentRepository extends Mock implements PaymentRepository {}

/// Unit-tests for the CheckOutBloc
void main() {
  group('CheckOutBloc', () {
    OrderRepository orderRepository;
    PaymentRepository paymentRepository;
    CheckOutBloc checkOutBloc;

    setUp(() {
      orderRepository = MockOrderRepository();
      paymentRepository = MockPaymentRepository();
      checkOutBloc = CheckOutBloc(
        orderRepository: orderRepository,
        paymentRepository: paymentRepository,
      );
    });

    test('should initialize with ContentStateStatus.initial status', () {
      expect(checkOutBloc.state, CheckOutState.initial(null));
    });

    // _mapAddCartToOrderRequestedToState
    blocTest<CheckOutBloc, CheckOutState>(
      'should map to CheckOutState upon AddCartToOrderRequested event',
      build: () {
        when(orderRepository.addCart(cartId: _mockCart.id))
            .thenAnswer((_) => Future.value(_mockOrder));
        return checkOutBloc;
      },
      act: (bloc) async {
        final event = AddCartToOrderRequested(_mockCart.id);
        bloc.add(event);
      },
      expect: <CheckOutState>[
        CheckOutState.loading(null),
        CheckOutState.success(_mockOrder)
      ],
    );

    blocTest<CheckOutBloc, CheckOutState>(
      'should emit error when addCart operation fails',
      build: () {
        when(orderRepository.addCart(cartId: _mockCart.id))
            .thenAnswer((_) => throw (FetchDataException('')));
        return checkOutBloc;
      },
      act: (bloc) async {
        final event = AddCartToOrderRequested(_mockCart.id);
        bloc.add(event);
      },
      expect: <CheckOutState>[
        CheckOutState.loading(null),
        CheckOutState.error(null)
      ],
    );

    // _mapClearOrderRequestedToState
    blocTest<CheckOutBloc, CheckOutState>(
      'should map to CheckOutState upon ClearOrderRequested event',
      build: () {
        when(orderRepository.clearOrder()).thenAnswer((_) => Future.value());
        return checkOutBloc;
      },
      act: (bloc) async {
        final event = ClearOrderRequested();

        bloc.add(event);
      },
      expect: <CheckOutState>[
        CheckOutState.loading(null),
        CheckOutState.success(null),
      ],
    );

    blocTest<CheckOutBloc, CheckOutState>(
      'should emit error when clearOrder operation fails',
      build: () {
        when(orderRepository.clearOrder())
            .thenAnswer((_) => throw (Exception()));
        return checkOutBloc;
      },
      act: (bloc) async {
        final event = ClearOrderRequested();

        bloc.add(event);
      },
      expect: <CheckOutState>[
        CheckOutState.loading(null),
        CheckOutState.error(null),
      ],
    );

    // _mapMakePaymentRequestedToState
    blocTest<CheckOutBloc, CheckOutState>(
      'should map to CheckOutState upon MakePaymentRequested event',
      build: () {
        when(paymentRepository.createPayment(
          orderId: _mockOrder.id,
          paymentMethodId: 1,
        )).thenAnswer((_) => Future.value());
        when(orderRepository.clearOrder()).thenAnswer((_) => Future.value());
        return checkOutBloc;
      },
      act: (bloc) async {
        final event = MakePaymentRequested(_mockOrder.id, 1);

        bloc.add(event);
      },
      expect: <CheckOutState>[
        CheckOutState.loading(null),
        CheckOutState.success(null),
      ],
    );

    blocTest<CheckOutBloc, CheckOutState>(
      'should emit error when createPayment operation fails',
      build: () {
        when(paymentRepository.createPayment(
          orderId: _mockOrder.id,
          paymentMethodId: 1,
        )).thenAnswer((_) => throw (FetchDataException('')));
        when(orderRepository.clearOrder()).thenAnswer((_) => Future.value());
        return checkOutBloc;
      },
      act: (bloc) async {
        final event = MakePaymentRequested(_mockOrder.id, 1);

        bloc.add(event);
      },
      expect: <CheckOutState>[
        CheckOutState.loading(null),
        CheckOutState.error(null),
      ],
    );
  });
}
