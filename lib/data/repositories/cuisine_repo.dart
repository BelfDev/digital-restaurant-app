import 'package:dr_app/data/models/remote/cuisine.dart';
import 'package:dr_app/services/api/cuisine_api_service.dart';

/// This class is the only data source for the Cuisine entity.
/// It should be seen as the single source of truth for fetching
/// or storing data.
class CuisineRepo {
  final _cuisineApiService = CuisineApiService();

  /// Retrieves all stored Cuisine entities
  Future<List<Cuisine>> fetchAllCuisines() async {
    final body = await _cuisineApiService.getCuisines();
    return body.results;
  }

  /// Retrieves a single Cuisine entity by the given identifier
  Future<Cuisine> fetchCuisine(int id) async {
    final body = await _cuisineApiService.getCuisineById(id);
    return body.results.length > 0 ? body.results[0] : null;
  }
}
