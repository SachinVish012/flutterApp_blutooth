import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var channel: FlutterMethodChannel?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        channel = FlutterMethodChannel(name: "com.test.test_blutooth/bluetooth", binaryMessenger: controller.binaryMessenger)
        channel?.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "enableBluetooth" {
                self?.enableBluetooth(result: result)
            } else if call.method == "checkBluetooth" {
                self?.checkBluetooth(result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        })
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func enableBluetooth(result: @escaping FlutterResult) {
        if let centralManager = CBCentralManager(delegate: nil, queue: nil, options: nil) {
            if centralManager.state == .poweredOn {
                result(nil) // Bluetooth is already enabled
            } else {
                result(FlutterError(code: "BLUETOOTH_OFF", message: "Bluetooth is turned off", details: nil))
            }
        } else {
            result(FlutterError(code: "UNAVAILABLE", message: "Bluetooth is not available on this device", details: nil))
        }
    }

    private func checkBluetooth(result: @escaping FlutterResult) {
        if let centralManager = CBCentralManager(delegate: nil, queue: nil, options: nil) {
            result(centralManager.state == .poweredOn)
        } else {
            result(false)
        }
    }
}
