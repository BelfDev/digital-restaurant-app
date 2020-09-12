import 'package:bloc_test/bloc_test.dart';
import 'package:dr_app/blocs/blocs.dart';
import 'package:dr_app/blocs/checkout/checkout_bloc.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/repositories/cart_repository.dart';
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

class MockCartRepository extends Mock implements CartRepository {}

class MockHomeBloc extends MockBloc implements HomeBloc {}

class MockCheckOutBloc extends MockBloc implements CheckOutBloc {}

void main() {
  group('CartBloc', () {
    CartRepository cartRepository;
    HomeBloc homeBloc;
    CheckOutBloc checkOutBloc;
    CartBloc cartBloc;

    setUp(() {
      cartRepository = MockCartRepository();
      homeBloc = MockHomeBloc();
      checkOutBloc = MockCheckOutBloc();
      cartBloc = CartBloc(
          homeBloc: homeBloc,
          cartRepository: cartRepository,
          checkOutBloc: checkOutBloc);
    });

    test('should initialize with ContentStateStatus.initial status', () {
      expect(cartBloc.state, CartState.initial());
    });

    // _mapNewCartRequestedToState
    blocTest<CartBloc, CartState>(
      'should map CartState upon NewCartRequested event',
      build: () {
        when(cartRepository.clearCart()).thenAnswer((_) => Future.value());
        when(cartRepository.createCart(outletId: _mockOutlet.id))
            .thenAnswer((_) => Future.value(_mockCart));
        return cartBloc;
      },
      act: (bloc) async {
        final event = NewCartRequested(_mockOutlet.id);
        bloc.add(event);
      },
      expect: <CartState>[
        CartState(
          status: ContentStateStatus.initial,
          cart: _mockCart,
          outletId: _mockOutlet.id,
        ),
      ],
    );

    // _mapClearCartRequestedToState
    blocTest<CartBloc, CartState>(
      'should map CartState upon ClearCartRequested event',
      build: () {
        when(cartRepository.clearCart()).thenAnswer((_) => Future.value());
        return cartBloc;
      },
      act: (bloc) async {
        final event = ClearCartRequested();
        bloc.add(event);
      },
      expect: <CartState>[
        CartState(
          status: ContentStateStatus.initial,
          cart: null,
          outletId: null,
        ),
      ],
    );

    // _mapAddToCartRequestedToState
    blocTest<CartBloc, CartState>(
      'should map CartState upon AddToCartRequested event',
      build: () {
        when(cartRepository.addCartItem(
                productId: _mockProduct.id, quantity: _mockProduct.quantity))
            .thenAnswer((_) => Future.value(_mockCart));
        return cartBloc;
      },
      act: (bloc) async {
        final event =
            AddToCartRequested(_mockProduct.id, _mockProduct.quantity);
        bloc.add(event);
      },
      expect: <CartState>[
        CartState(
          status: ContentStateStatus.loadInProgress,
        ),
        CartState(
          status: ContentStateStatus.loadSuccess,
          cart: _mockCart,
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'should emit error when addCartItem operation fails',
      build: () {
        when(cartRepository.addCartItem(
                productId: _mockProduct.id, quantity: _mockProduct.quantity))
            .thenAnswer((_) => Future.value(throw (FetchDataException(''))));
        return cartBloc;
      },
      act: (bloc) async {
        final event =
            AddToCartRequested(_mockProduct.id, _mockProduct.quantity);
        bloc.add(event);
      },
      expect: <CartState>[
        CartState(
          status: ContentStateStatus.loadInProgress,
        ),
        CartState(
          status: ContentStateStatus.loadFailure,
        ),
      ],
    );

    // _mapCartRequestedToState
    blocTest<CartBloc, CartState>(
      'should map CartState upon CartRequested event',
      build: () {
        when(cartRepository.fetchCart())
            .thenAnswer((_) => Future.value(_mockCart));
        return cartBloc;
      },
      act: (bloc) async {
        final event = CartRequested();
        bloc.add(event);
      },
      expect: <CartState>[
        CartState(
          status: ContentStateStatus.loadInProgress,
          cart: _mockCart,
        ),
        CartState(
          status: ContentStateStatus.loadSuccess,
          cart: _mockCart,
        ),
      ],
    );

    // _mapRemoveCartItemRequestedToState
    blocTest<CartBloc, CartState>(
      'should map CartState upon RemoveCartItemRequested event',
      build: () {
        when(cartRepository.removeCartItem(productId: _mockProduct.id))
            .thenAnswer((_) => Future.value());
        when(cartRepository.fetchCart())
            .thenAnswer((_) => Future.value(_mockCart));
        return cartBloc;
      },
      act: (bloc) async {
        final event = RemoveCartItemRequested(_mockProduct.id);
        bloc.add(event);
      },
      expect: <CartState>[
        CartState(
          status: ContentStateStatus.loadInProgress,
          cart: _mockCart,
        ),
        CartState(
          status: ContentStateStatus.loadSuccess,
          cart: _mockCart,
        ),
      ],
    );
  });
}
