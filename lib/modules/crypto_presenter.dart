import 'package:crypto_app/dependency_injection.dart';

import '../data/crypto_data.dart';

abstract class CryptoListViewContract {
  void onLoadCryptoComplete(List<Crypto> items);
  void onLoadCryptoError();
}

class CryptoListPresenter {
  late final CryptoListViewContract _view;
  late CryptoRepository _repository;

  CryptoListPresenter(this._view) {
    _repository = Injector().cryptoRepository;
  }

  void loadCurrencies() {
    _repository
        .fetchCurrencies()
        .then((value) => _view.onLoadCryptoComplete(value))
        .catchError((onError) {
      return _view.onLoadCryptoError();
    });
  }
}
