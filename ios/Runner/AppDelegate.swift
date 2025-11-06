import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
          GeneratedPluginRegistrant.register(with: self)
      let controller = window?.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel(name: "com.example.seven/native", binaryMessenger: controller.binaryMessenger)
      
      channel.setMethodCallHandler {(call, result) in
          if call.method == "getDeviceName" {
              self.getDeviceName(result: result)
          }
          else {
              result(FlutterMethodNotImplemented)
          }
      }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func getDeviceName(result: FlutterResult) {
        let deviceName = UIDevice.current.name
        result(deviceName)
    }
}
