import 'package:flutter/material.dart';

class Crypto {
  String name;
  String priceINR;
  String percentChange1h;

  Crypto({
    required this.name,
    required this.priceINR,
    required this.percentChange1h,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    final quote = json['quote']['INR'];
    return Crypto(
      name: json['name'],
      priceINR: quote['price'].toStringAsFixed(2),
      percentChange1h: quote['percent_change_1h'].toString(),
    );
  }
}

abstract class CryptoRepository {
  Future<List<Crypto>> fetchCurrencies();
}

class FetchDataException implements Exception {
  final String? message;

  FetchDataException([this.message]);

  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'FetchDataException: $message';
  }
}
