/// A generic collection of entities.
class Results<T> {
  final List<T> results;

  Results(this.results);

  factory Results.fromJson(Map<String, dynamic> json, Function fromJson) {
    final resultNode = json['result'];
    if (resultNode is List) {
      final items = resultNode.cast<Map<String, dynamic>>();
      return Results<T>(
          List<T>.from(items.map((itemsJson) => fromJson(itemsJson))));
    } else {
      final item = fromJson(resultNode);
      return Results<T>([item]);
    }
  }
}
