import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:contacts_app/imports.dart';

class AppBaseComponent {
  AppBaseComponent._privateConstructor();
  final Connectivity _connectivity = Connectivity();

  String currentChatRoom = '';

  RxBool completed = true.obs;
  static final AppBaseComponent instance =
      AppBaseComponent._privateConstructor()..initNetwork();

  final StreamController<bool> progressStreamController =
      StreamController<bool>.broadcast();
  final StreamController<bool> networkStreamController =
      StreamController<bool>.broadcast();

  Stream<bool> get progressStream => progressStreamController.stream;
  Stream<bool> get networkStream => networkStreamController.stream;

  void initNetwork() async {
    var initData = await _connectivity.checkConnectivity();
    if (initData == ConnectivityResult.ethernet ||
        initData == ConnectivityResult.mobile ||
        initData == ConnectivityResult.wifi ||
        initData == ConnectivityResult.vpn) {
      networkStreamController.sink.add(true);
      stopLoading();
    } else {
      networkStreamController.sink.add(false);
      startLoading();
    }
    _connectivity.onConnectivityChanged.listen((ConnectivityResult event) {
      if (event == ConnectivityResult.ethernet ||
          event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi ||
          event == ConnectivityResult.vpn) {
        networkStreamController.sink.add(true);
        stopLoading();
      } else {
        networkStreamController.sink.add(false);
        startLoading();
      }
    });
  }

  void startLoading() {
    completed(false);
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        progressStreamController.sink.add(true);
      },
    );
  }

  void stopLoading() {
    progressStreamController.sink.add(false);
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        completed(true);
      },
    );
  }
}
