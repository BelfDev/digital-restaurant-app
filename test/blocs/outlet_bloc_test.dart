// Mock Bloc
import 'package:bloc_test/bloc_test.dart';
import 'package:dr_app/blocs/content_state_status.dart';
import 'package:dr_app/blocs/outlet/outlet_bloc.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/repositories/outlet_respository.dart';
import 'package:dr_app/services/api/network_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock objects

final Category _mockCategory = Category('TestCategory', null);
final Cuisine _mockCuisine = Cuisine(1, 'Italian', null);
final List<Product> _mockProductList = List.generate(
    3,
    (index) => Product(index, 'Test', 10, 'Description', 10, null, const [],
        [_mockCategory], 10));
final List<Outlet> _mockOutletList = List.generate(3,
    (index) => Outlet(index, 'Outlet $index', 4, 4, _mockCuisine, null, null));

class MockOutletRepository extends Mock implements OutletRepository {}

/// Unit-tests for the OutletBloc
void main() {
  group('OutletBloc', () {
    MockOutletRepository outletRepository;
    OutletBloc outletBloc;

    setUp(() {
      outletRepository = MockOutletRepository();
      outletBloc = OutletBloc(outletRepository: outletRepository);
    });

    test('should initialize with ContentStateStatus.initial status', () {
      expect(outletBloc.state, OutletState.initial());
      expect(outletBloc.state.status, ContentStateStatus.initial);
    });

    blocTest<OutletBloc, OutletState>(
      'should fetch outlet products when requested',
      build: () {
        when(outletRepository.fetchAllOutletProducts(1))
            .thenAnswer((_) => Future.value(_mockProductList));
        return outletBloc;
      },
      act: (bloc) async {
        final event = OutletProductsRequested(outletId: 1);
        bloc.add(event);
      },
      expect: <OutletState>[
        OutletState.loading(),
        OutletState.success({_mockCategory: _mockProductList}, null),
      ],
    );

    blocTest<OutletBloc, OutletState>(
      'should emit error when fetchAllOutlets operation fails',
      build: () {
        when(outletRepository.fetchAllOutletProducts(1))
            .thenAnswer((_) => throw (FetchDataException('')));
        return outletBloc;
      },
      act: (bloc) async {
        final event = OutletProductsRequested(outletId: 1);
        bloc.add(event);
      },
      expect: <OutletState>[
        OutletState.loading(),
        OutletState.error(),
      ],
    );

    blocTest<OutletBloc, OutletState>(
      'should fetch outlets when requested',
      build: () {
        when(outletRepository.fetchAllOutlets(cuisine: _mockCuisine.title))
            .thenAnswer((_) => Future.value(_mockOutletList));
        return outletBloc;
      },
      act: (bloc) async {
        final event = OutletsRequested(cuisine: _mockCuisine.title);
        bloc.add(event);
      },
      expect: <OutletState>[
        OutletState.loading(),
        OutletState.success(null, _mockOutletList),
      ],
    );

    blocTest<OutletBloc, OutletState>(
      'should emit error when fetchAllOutlets operation fails',
      build: () {
        when(outletRepository.fetchAllOutlets(cuisine: 'Italian'))
            .thenAnswer((_) => throw (FetchDataException('')));
        return outletBloc;
      },
      act: (bloc) async {
        final event = OutletsRequested(cuisine: _mockCuisine.title);
        bloc.add(event);
      },
      expect: <OutletState>[
        OutletState.loading(),
        OutletState.error(),
      ],
    );
  });
}
