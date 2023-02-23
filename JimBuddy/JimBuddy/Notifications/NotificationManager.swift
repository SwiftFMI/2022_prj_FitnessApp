//
//  NotificationManager.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 24.02.23.
//

import Foundation
import UserNotifications

protocol NotificationManagerProtocol {
    
    func scheduleNotification(waitTime: Double) -> String
    
    func removeScheduledNotification(notificationId: String)
}


class NotificationManager {
    
    static let shared = NotificationManager()
    
    let userNotificationCenter: UNUserNotificationCenter
    
    init(userNotificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        self.userNotificationCenter = userNotificationCenter
    }
    
    func scheduleNotification(waitTime: Double) -> String{
            let content = UNMutableNotificationContent()
            content.title = "Jim Buddy"
            content.body = "You haven't logged you food for today. Would you like to do it now?"
            content.sound = .default
        
            let date = Date().addingTimeInterval(waitTime)

            let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let id = UUID().uuidString
            
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            
            userNotificationCenter.add(request) { _ in
            }
            
            return id
        }
        
        func removeScheduledNotification(notificationId: String) {
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationId])
        }

    
}
