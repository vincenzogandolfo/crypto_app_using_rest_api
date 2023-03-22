import 'dart:convert';
import 'package:crypto_app_using_rest_api/models/crypto_listing_model.dart';
import 'package:http/http.dart' as http;

class CryptoListingRepository {
  static Future<List<CryptoListingModel>> all() async {
    final url = Uri.parse(
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest',
    );

    final response = await http.get(url, headers: {
      'X-CMC_PRO_API_KEY': '72e1c2b5-052e-4a28-aa75-3d3c5f89ee20',
    });

    final jsonData = json.decode(response.body);

    final cryptoListing = (jsonData["data"] as List<dynamic>).map((cryptoData) {
      return CryptoListingModel.fromData(cryptoData);
    }).toList();

    return cryptoListing;
  }
}
