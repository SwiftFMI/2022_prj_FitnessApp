//
//  JimBuddyApp.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 28.12.22.
//

import FirebaseCore
import SwiftUI
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        FirebaseApp.configure()
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        return true
    }
}

@main
struct JimBuddyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceImpl()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch sessionService.state {
                case .loggedIn:
                    HomePageView()
                        .environmentObject(sessionService)
                        .onAppear {
                            let health = HealthKitService()
                            health.requestPermission { _ in }
                        }
                case .loggedOut:
                    LoginView()
                }
            }.accentColor(Colors.darkGrey)
        }
    }
}
