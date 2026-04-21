import Expo
import React
import ReactAppDependencyProvider
import UserNotifications
import react_native_dengage
import Dengage

@UIApplicationMain
public class AppDelegate: ExpoAppDelegate {
  var window: UIWindow?

  var reactNativeDelegate: ExpoReactNativeFactoryDelegate?
  var reactNativeFactory: RCTReactNativeFactory?

  public override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    let delegate = ReactNativeDelegate()
    let factory = ExpoReactNativeFactory(delegate: delegate)
    delegate.dependencyProvider = RCTAppDependencyProvider()

    reactNativeDelegate = delegate
    reactNativeFactory = factory
    bindReactNativeFactory(factory)

#if os(iOS) || os(tvOS)
    window = UIWindow(frame: UIScreen.main.bounds)
    // @generated begin @dengage-tech/expo-dengage
    UNUserNotificationCenter.current().delegate = self
    let dengageCoordinator = DengageRNCoordinator.staticInstance
    dengageCoordinator.setupDengage(
      key: "T1B6RzcUfNtWTYP7niBXfepo1HXVU6yYl6oSJ1lYr2E58yenBHtN_s_l_KzCTsrFoD4K0GblmpDKENuNvTX_p_l_cXKji0ffYqiY3ZcOaWwz1wjBQYqS0Q9MQ89FGyuOKKBN6NIXcyt3qUr4ZyxmuOS_p_l_0pGdlw_e_q__e_q_" as NSString,
      appGroupsKey: "group.com.dengage.expodengageexample.dengage" as NSString,
      launchOptions: launchOptions as NSDictionary?,
      application: application,
      askNotificationPermission: true,
      enableGeoFence: true,
      disableOpenURL: false,
      badgeCountReset: false,
      logVisible: true
    )
#if DEBUG
    Dengage.setDevelopmentStatus(isDebug: true)
#else
    Dengage.setDevelopmentStatus(isDebug: false)
#endif
    // @generated end @dengage-tech/expo-dengage
    factory.startReactNative(
      withModuleName: "main",
      in: window,
      launchOptions: launchOptions)
#endif

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


  public override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    DengageRNCoordinator.staticInstance.registerForPushToken(deviceToken: deviceToken)
  }

  // Linking API
  public override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    return super.application(app, open: url, options: options) || RCTLinkingManager.application(app, open: url, options: options)
  }

  // Universal Links
  public override func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
  ) -> Bool {
    let result = RCTLinkingManager.application(application, continue: userActivity, restorationHandler: restorationHandler)
    return super.application(application, continue: userActivity, restorationHandler: restorationHandler) || result
  }
}

class ReactNativeDelegate: ExpoReactNativeFactoryDelegate {
  // Extension point for config-plugins

  override func sourceURL(for bridge: RCTBridge) -> URL? {
    // needed to return the correct URL for expo-dev-client.
    bridge.bundleURL ?? bundleURL()
  }

  override func bundleURL() -> URL? {
#if DEBUG
    return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: ".expo/.virtual-metro-entry")
#else
    return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
#endif
  }
}

// @generated begin @dengage-tech/expo-dengage-extension
extension AppDelegate: UNUserNotificationCenterDelegate {
  public func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.banner, .sound, .badge])
  }

  public func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    DengageRNCoordinator.staticInstance.didReceivePush(
      center,
      response,
      withCompletionHandler: completionHandler
    )
  }
}
// @generated end @dengage-tech/expo-dengage-extension
