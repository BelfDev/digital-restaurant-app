import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/models/remote/outlet.dart';
import 'package:dr_app/services/api/outlet_api_client.dart';

/// This class is the only data source for the Outlet entity.
/// It should be seen as the single source of truth for fetching
/// or storing data.
class OutletRepository {
  final _outletApiService = OutletApiClient();

  /// Retrieves all stored Outlet entities
  Future<List<Outlet>> fetchAllOutlets([String city, String cuisine]) async {
    final body = await _outletApiService.getOutlets(city, cuisine);
    return body.results;
  }

  /// Retrieves all stored Outlet entities
  Future<List<Outlet>> fetchAllFeaturedOutlets([String city]) async {
    final body = await _outletApiService.getFeaturedOutlets(city);
    return body.results;
  }

  /// Retrieves a single Outlet entity by the given identifier
  Future<Outlet> fetchOutlet(int id) async {
    final body = await _outletApiService.getOutletById(id);
    return body.results.length > 0 ? body.results[0] : null;
  }

  /// Retrieves [Product]s associated with a specific [Outlet]
  Future<List<Product>> fetchAllOutletProducts(int id) async {
    final body = await _outletApiService.getOutletProducts(id);
    return body.results;
  }

  /// Retrieves featured [Product]s associated with a specific [Outlet]
  Future<List<Product>> fetchAllOutletFeaturedProducts(int id) async {
    final body = await _outletApiService.getOutletFeaturedProducts(id);
    return body.results;
  }
}
