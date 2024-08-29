//
//  AppDelegate.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/12/24.
//

import Foundation
import SwiftUI

import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
      Thread.sleep(forTimeInterval: 1)
      FirebaseApp.configure()
      
      return true
  }
}
