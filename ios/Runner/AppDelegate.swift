import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     if #available(iOS 10.0, *) {
         UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
       }

    // TODO: Add your API key
    GMSServices.provideAPIKey("AIzaSyAF5oOYA_Jj4syBFV-5Vt2TDTGOYEhh2v8")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
