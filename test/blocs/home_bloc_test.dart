import 'package:bloc_test/bloc_test.dart';
import 'package:dr_app/blocs/blocs.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/repositories/cuisine_repository.dart';
import 'package:dr_app/data/repositories/outlet_respository.dart';
import 'package:dr_app/services/api/network_exception.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// Mock objects

final Category _mockCategory = Category('TestCategory', null);
final Cuisine _mockCuisine = Cuisine(1, 'Italian', null);
final Location _mockLocation = Location('Glasgow');
final Outlet _mockOutlet =
    Outlet(1, 'Outlet 1', 4, 4, _mockCuisine, null, _mockLocation);
final List<Product> _mockProductList = List.generate(
    3,
    (index) => Product(index, 'Test', 10, 'Description', 10, null, const [],
        [_mockCategory], 10));
final List<Outlet> _mockOutletList = List.generate(
    3,
    (index) => Outlet(
        index, 'Outlet $index', 4, 4, _mockCuisine, null, _mockLocation));

final List<Cuisine> _mockCuisineList =
    List.generate(3, (index) => Cuisine(index, 'Cuisine $index', null));

class MockCuisineRepository extends Mock implements CuisineRepository {}

class MockOutletRepository extends Mock implements OutletRepository {}

void main() {
  group('HomeBloc', () {
    CuisineRepository cuisineRepository;
    OutletRepository outletRepository;
    HomeBloc homeBloc;

    setUp(() {
      cuisineRepository = MockCuisineRepository();
      outletRepository = MockOutletRepository();
      homeBloc = HomeBloc(
        cuisineRepository: cuisineRepository,
        outletRepository: outletRepository,
      );
    });

    test('should initialize with ContentStateStatus.initial status', () {
      expect(homeBloc.state, HomeState.initial());
      expect(homeBloc.state.homeOutletStatus, ContentStateStatus.initial);
      expect(homeBloc.state.productsStatus, ContentStateStatus.initial);
      expect(homeBloc.state.featuredProductsStatus, ContentStateStatus.initial);
      expect(homeBloc.state.nearbyOutletsStatus, ContentStateStatus.initial);
      expect(homeBloc.state.cuisineStatus, ContentStateStatus.initial);
      expect(homeBloc.state.featuredOutletsStatus, ContentStateStatus.initial);
    });

    // _mapCheckInRequestedToState
    blocTest<HomeBloc, HomeState>(
      'should map to check-in state upon CheckInRequested event',
      build: () {
        when(outletRepository.fetchOutlet(_mockOutlet.id))
            .thenAnswer((_) => Future.value(_mockOutlet));
        return homeBloc;
      },
      act: (bloc) async {
        final event = CheckInRequested(_mockOutlet.id);
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          mode: HomeMode.checkedIn,
          homeOutletStatus: ContentStateStatus.loadInProgress,
          featuredOutletsStatus: ContentStateStatus.initial,
          cuisineStatus: ContentStateStatus.initial,
          nearbyOutletsStatus: ContentStateStatus.initial,
        ),
        HomeState(
          mode: HomeMode.checkedIn,
          homeOutletStatus: ContentStateStatus.loadSuccess,
          homeOutlet: _mockOutlet,
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'should emit error when fetchOutlet operation fails',
      build: () {
        when(outletRepository.fetchOutlet(_mockOutlet.id))
            .thenAnswer((_) => throw (FetchDataException('')));
        return homeBloc;
      },
      act: (bloc) async {
        final event = CheckInRequested(_mockOutlet.id);
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          mode: HomeMode.checkedIn,
          homeOutletStatus: ContentStateStatus.loadInProgress,
        ),
        HomeState(
          mode: HomeMode.checkedOut,
          homeOutletStatus: ContentStateStatus.loadFailure,
        ),
      ],
    );

    // _mapCheckOutRequestedToState
    blocTest<HomeBloc, HomeState>(
      'should map to check-out state upon CheckOutRequested event',
      build: () => homeBloc,
      act: (bloc) async {
        final event = CheckOutRequested();
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          mode: HomeMode.checkedOut,
          homeOutlet: null,
          homeOutletStatus: ContentStateStatus.initial,
          featuredProducts: const [],
          categories: const {},
        ),
      ],
    );

    // _mapOutletFeaturedProductsRequestedToState
    blocTest<HomeBloc, HomeState>(
      'should map to check-in state upon OutletFeaturedProductsRequested event',
      build: () {
        when(outletRepository.fetchAllOutletFeaturedProducts(_mockOutlet.id))
            .thenAnswer((_) => Future.value(_mockProductList));
        return homeBloc;
      },
      act: (bloc) async {
        final event = OutletFeaturedProductsRequested(_mockOutlet.id);
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          featuredProductsStatus: ContentStateStatus.loadInProgress,
        ),
        HomeState(
          featuredProductsStatus: ContentStateStatus.loadSuccess,
          featuredProducts: _mockProductList,
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'should emit error when fetchAllOutletFeaturedProducts operation fails',
      build: () {
        when(outletRepository.fetchAllOutletFeaturedProducts(_mockOutlet.id))
            .thenAnswer((_) => throw (FetchDataException('')));
        return homeBloc;
      },
      act: (bloc) async {
        final event = OutletFeaturedProductsRequested(_mockOutlet.id);
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          featuredProductsStatus: ContentStateStatus.loadInProgress,
        ),
        HomeState(
          featuredProductsStatus: ContentStateStatus.loadFailure,
        ),
      ],
    );

    // _mapOutletProductsRequestedToState
    blocTest<HomeBloc, HomeState>(
      'should map to check-in state upon OutletProductsRequested event',
      build: () {
        when(outletRepository.fetchAllOutletProducts(_mockOutlet.id))
            .thenAnswer((_) => Future.value(_mockProductList));
        return homeBloc;
      },
      act: (bloc) async {
        final event = OutletProductsRequested(_mockOutlet.id);
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          productsStatus: ContentStateStatus.loadInProgress,
        ),
        HomeState(
          productsStatus: ContentStateStatus.loadSuccess,
          categories: {_mockCategory: _mockProductList},
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'should emit error when OutletProductsRequested operation fails',
      build: () {
        when(outletRepository.fetchAllOutletProducts(_mockOutlet.id))
            .thenAnswer((_) => throw (FetchDataException('')));
        return homeBloc;
      },
      act: (bloc) async {
        final event = OutletProductsRequested(_mockOutlet.id);
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          productsStatus: ContentStateStatus.loadInProgress,
        ),
        HomeState(
          productsStatus: ContentStateStatus.loadFailure,
        ),
      ],
    );

    // _mapFeaturedOutletsRequestedToState
    blocTest<HomeBloc, HomeState>(
      'should map to check-in state upon FeaturedOutletsRequested event',
      build: () {
        when(outletRepository
                .fetchAllFeaturedOutlets(_mockOutlet.location.city))
            .thenAnswer((_) => Future.value(_mockOutletList));
        return homeBloc;
      },
      act: (bloc) async {
        final event = FeaturedOutletsRequested(city: _mockOutlet.location.city);
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          featuredOutletsStatus: ContentStateStatus.loadInProgress,
        ),
        HomeState(
          featuredOutletsStatus: ContentStateStatus.loadSuccess,
          featuredOutlets: _mockOutletList,
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'should emit error when OutletProductsRequested operation fails',
      build: () {
        when(outletRepository
                .fetchAllFeaturedOutlets(_mockOutlet.location.city))
            .thenAnswer((_) => throw (FetchDataException('')));
        return homeBloc;
      },
      act: (bloc) async {
        final event = FeaturedOutletsRequested(city: _mockOutlet.location.city);
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          featuredOutletsStatus: ContentStateStatus.loadInProgress,
        ),
        HomeState(
          featuredOutletsStatus: ContentStateStatus.loadFailure,
        ),
      ],
    );

    // _mapCuisinesRequestedToState
    blocTest<HomeBloc, HomeState>(
      'should map to check-in state upon CuisinesRequested event',
      build: () {
        when(cuisineRepository.fetchAllCuisines())
            .thenAnswer((_) => Future.value(_mockCuisineList));
        return homeBloc;
      },
      act: (bloc) async {
        final event = CuisinesRequested();
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          cuisineStatus: ContentStateStatus.loadInProgress,
        ),
        HomeState(
          cuisineStatus: ContentStateStatus.loadSuccess,
          cuisines: _mockCuisineList,
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'should emit error when CuisinesRequested operation fails',
      build: () {
        when(cuisineRepository.fetchAllCuisines())
            .thenAnswer((_) => throw (FetchDataException('')));
        return homeBloc;
      },
      act: (bloc) async {
        final event = CuisinesRequested();
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          cuisineStatus: ContentStateStatus.loadInProgress,
        ),
        HomeState(
          cuisineStatus: ContentStateStatus.loadFailure,
        ),
      ],
    );

    // _mapNearbyOutletsRequestedToState
    blocTest<HomeBloc, HomeState>(
      'should map to check-in state upon NearbyOutletsRequested event',
      build: () {
        when(outletRepository.fetchAllOutlets(city: _mockOutlet.location.city))
            .thenAnswer((_) => Future.value(_mockOutletList));
        return homeBloc;
      },
      act: (bloc) async {
        final event = NearbyOutletsRequested(city: _mockOutlet.location.city);
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          nearbyOutletsStatus: ContentStateStatus.loadInProgress,
        ),
        HomeState(
          nearbyOutletsStatus: ContentStateStatus.loadSuccess,
          nearbyOutlets: _mockOutletList,
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'should emit error when NearbyOutletsRequested operation fails',
      build: () {
        when(outletRepository.fetchAllOutlets(city: _mockOutlet.location.city))
            .thenAnswer((_) => throw (FetchDataException('')));
        return homeBloc;
      },
      act: (bloc) async {
        final event = NearbyOutletsRequested(city: _mockOutlet.location.city);
        bloc.add(event);
      },
      expect: <HomeState>[
        HomeState(
          nearbyOutletsStatus: ContentStateStatus.loadInProgress,
        ),
        HomeState(
          nearbyOutletsStatus: ContentStateStatus.loadFailure,
        ),
      ],
    );
  });
}
