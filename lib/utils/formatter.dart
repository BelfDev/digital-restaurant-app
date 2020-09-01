class Formatter {
  static String convertToDollarSign(int priceLevel) {
    return List.generate(priceLevel, (_) => '\$').join();
  }

  Formatter._();
}
