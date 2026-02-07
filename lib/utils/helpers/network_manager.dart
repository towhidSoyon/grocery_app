/*
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'helper_functions.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  /// Initialize the network manager and set up a stream to continually check the connection status.
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus as void Function(List<ConnectivityResult> event)?) as StreamSubscription<ConnectivityResult>;
  }

  /// Update the connection status based on changes in connectivity and show a relevant popup for no internet connection.
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      UHelperFunctions.warningSnackBar(title: 'No Internet Connection');
    }
  }

  /// Check the internet connection status.
  /// Returns `true` if connected, `false` otherwise.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Dispose or close the active connectivity stream.
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}*/
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'helper_functions.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  final Rx<ConnectivityResult> _connectionStatus =
      ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Update connection status
  Future<void> _updateConnectionStatus(
      List<ConnectivityResult> results) async {
    final isConnected = results.any(
          (result) => result != ConnectivityResult.none,
    );

    _connectionStatus.value =
    isConnected ? results.first : ConnectivityResult.none;

    if (!isConnected) {
      UHelperFunctions.warningSnackBar(
        title: 'No Internet Connection',
      );
    }
  }

  /// Check internet connection status
  Future<bool> isConnected() async {
    try {
      final results = await _connectivity.checkConnectivity();
      return results.any(
            (result) => result != ConnectivityResult.none,
      );
    } on PlatformException {
      return false;
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
