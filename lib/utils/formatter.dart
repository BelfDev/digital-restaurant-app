class Formatter {
  static String convertToDollarSign(int priceLevel) {
    return List.generate(priceLevel, (_) => '\$').join();
  }

  static String convertToMoney(double value) {
    return '\$ $value';
  }

  Formatter._();
}
