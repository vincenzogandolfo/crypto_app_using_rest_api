class CryptoListingModel {
  final String symbol;
  final String name;
  final double price;
  final double percentChange24h;

  const CryptoListingModel({
    required this.symbol,
    required this.name,
    required this.price,
    required this.percentChange24h,
  });

  factory CryptoListingModel.fromData(Map<String, dynamic> data) {
    final symbol = data["symbol"];
    final name = data["name"];
    final price = data["quote"]["USD"]["price"];
    final percentChange24h = data["quote"]["USD"]["percent_change_24h"];

    return CryptoListingModel(
      symbol: symbol,
      name: name,
      price: price,
      percentChange24h: percentChange24h,
    );
  }
}
