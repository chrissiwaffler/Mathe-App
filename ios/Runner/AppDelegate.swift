import UIKit
import Flutter
// import flutter_downloader

import Sentry

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)

    // add sentry support
    SentrySDK.start { options in
        options.dsn = "https://a2f38ac776c84defa34bb8a2ab9d9286@o942504.ingest.sentry.io/5891362"

        // Example uniform sample rate: capture 100% of transactions
        // In Production you will probably want a smaller number such as 0.5 for 50%
        options.tracesSampleRate = 1.0

        // OR if you prefer, determine traces sample rate based on the
        // sampling context
        // options.tracesSampler = { context in
        //     // Don't miss any transactions for VIP users 
        //     if context?["vip"] as? Bool == true { 
        //         return 1.0 
        //     } else { 
        //         return 0.25 // 25% for everything else
        //     }
        // }
    }


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// private func registerPlugins(registry: FlutterPluginRegistry) {
//     if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
//        FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin"))
//     }
// }
