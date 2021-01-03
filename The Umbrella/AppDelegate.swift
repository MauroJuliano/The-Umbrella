//
//  AppDelegate.swift
//  The Umbrella
//
//  Created by Lestad on 2020-08-04.
//  Copyright © 2020 Lestad. All rights reserved.
//

import UIKit
import GooglePlaces
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        GMSPlacesClient.provideAPIKey("AIzaSyDXg7Q7lDqpSHCrDVflFf-MoQY6eu9Xv6U")
        FirebaseApp.configure()
        
        let story = UIStoryboard(name: "Home", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        return true
    }


}

