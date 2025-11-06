package com.example.seven

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Build

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.seven/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getDeviceName" -> {
                    val deviceName = "${Build.MANUFACTURER} ${Build.MODEL}"
                    result.success(deviceName)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}

