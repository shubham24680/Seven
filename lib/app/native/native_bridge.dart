import 'dart:developer';
import 'package:flutter/services.dart';

class NativeBridge {
  static const _channel = MethodChannel("com.example.seven/native");

  static Future<String?> getDeviceName() async {
    try {
      final result = await _channel.invokeMethod<String>("getDeviceName");
      return result;
    } on PlatformException catch (e) {
      log("Native Error: ${e.message}");
      return null;
    }
  }
}
