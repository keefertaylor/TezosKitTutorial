// Copyright Keefer Taylor, 2019.
import UIKit

// TODO:
// - Should probably discuss how to use Carthage?
// - PromiseKit promises

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var vc: UIViewController?
  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds);

    // TODO: Rename UIViewController to be sensible.
    let viewController = ViewController()

    window.rootViewController = viewController
    window.makeKeyAndVisible()

    self.vc = viewController
    self.window = window
    
    return true
  }
}

