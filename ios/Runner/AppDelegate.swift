import UIKit
import Flutter
import Firebase


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
override func application(
    _ application: UIApplication,
didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
 FirebaseApp.configure()
    
 Messaging.messaging().delegate = self
 GeneratedPluginRegistrant.register(with: self)

  if #available(iOS 10.0, *) {
    // For iOS 10 display notification (sent via APNS)
    UNUserNotificationCenter.current().delegate = self
    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
          print("Firebase registration token: \(fcmToken!)")

          let dataDict:[String: String] = ["token": fcmToken!]
          NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
          // If necessary send token to application server
      }
    UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
} else {
    let settings: UIUserNotificationSettings =
    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
    application.registerUserNotificationSettings(settings)
}
application.registerForRemoteNotifications()
return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
   }
