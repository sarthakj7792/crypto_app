import 'package:crypto_app/data/crypto_data.dart';

class MockCryptoRepository implements CryptoRepository {
  @override
  Future<List<Crypto>> fetchCurrencies() {
    return Future.value(currencies);
  }
}

var currencies = [
  Crypto(name: 'Bitcoin', priceINR: '2500000', percentChange1h: '-0.7'),
  Crypto(name: 'Ethereum', priceINR: '650', percentChange1h: '0.85'),
  Crypto(name: 'Ripple', priceINR: '200', percentChange1h: '-0.25'),
];
