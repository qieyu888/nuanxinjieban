import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  var AAAA_drLaunchOptions_BBBB: [UIApplication.LaunchOptionsKey: Any]?
  var AAAA_drSceneConnectOptions_BBBB: UIScene.ConnectionOptions?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.AAAA_drLaunchOptions_BBBB = launchOptions

    BDASignalBootstrap.start(
      launchOptions: self.AAAA_drLaunchOptions_BBBB,
      connect: self.AAAA_drSceneConnectOptions_BBBB
    )

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
