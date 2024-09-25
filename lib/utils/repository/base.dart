import 'package:flutter/cupertino.dart';

import '../services/base.dart';

enum Status { none, loading, error, loaded, noData }

class BaseRepository<T extends BaseService> with ChangeNotifier {
  final BuildContext? context;
  final T service;
  Status? _status;

  BaseRepository(this.service, [this.context]);

  bool get isLoading => _status == Status.loading;

  bool get loadingFailed => _status == Status.error;

  bool get isLoaded => _status == Status.loaded;

  bool get noData => _status == Status.noData;
  String? errorMessage = '';

  String? get error => errorMessage;

  void resetStatus() {
    _status = Status.none;
  }

  // callback sử dụng lắng nghe response nhiều api trong cùng 1 widget
  void startLoading([Function()? callback]) {
    if (callback != null) {
      callback();
      Future.delayed(Duration.zero, () => notifyListeners());
    } else {
      _status = Status.loading;
      notifyListeners();
    }
  }

  void finishLoading([Function()? callback]) {
    if (callback != null) {
      callback();
      notifyListeners();
    } else {
      _status = Status.loaded;
      notifyListeners();
    }
  }

  void receivedNoData([Function()? callback]) {
    if (callback != null) {
      callback();
      notifyListeners();
    } else {
      _status = Status.noData;
      notifyListeners();
    }
  }

  void receivedError([Function()? callback]) {
    if (callback != null) {
      callback();
      notifyListeners();
    } else {
      _status = Status.error;
      notifyListeners();
    }
  }

  void update() {
    notifyListeners();
  }
}
