// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:crypto_app/data/crypto_data.dart';
import 'package:http/http.dart' as http;

class ProdCryptoRepository implements CryptoRepository {
  @override
  Future<List<Crypto>> fetchCurrencies() async {
    const String cryptourl =
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=500&convert=INR';
    http.Response response = await http.get(Uri.parse(cryptourl), headers: {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': 'fe4565d0-6556-452e-8f45-2d11b0c4116a'
    });
    Map<String, dynamic> data = json.decode(response.body);
    final List responseBody = data['data'];
    final statusCode = response.statusCode;
    if (statusCode != 200 || responseBody == null) {
      throw FetchDataException(
          'An Error occured : [Status Code : $statusCode]');
    }
    return responseBody.map((e) => Crypto.fromJson(e)).toList();
  }
}
