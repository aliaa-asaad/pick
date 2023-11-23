import UIKit
import Flutter
import PushNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    let pushNotifications = PushNotifications.shared

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // GMSServices.provideAPIKey("AIzaSyChp0nLB3HQYzXyCqmHSK3-N2c316gdzD8")
      self.pushNotifications.start(instanceId: "01aef67e-5a58-4f21-931f-65f3485464cc")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
