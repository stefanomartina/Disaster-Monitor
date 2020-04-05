//
//  LocalNotificationManager.swift
//  Disaster Monitor
//
//  Created by Francesco Peressini on 04/04/2020.
//  Copyright © 2020 Stefano Martina. All rights reserved.
//

import CoreLocation
import UserNotifications

final class LocalNotificationsManager {
    
    func scheduleEventNotification(events: [Event], places: [Region]) {
        
        // Via Ronchi, 39-31, 20134 Milano MI
        //let hardCodedCoordinates = CLLocation(latitude: 45.489031, longitude: 9.236980)
        
        if !places.isEmpty {
            for place in places {
                let placeCoordinates = CLLocation(latitude: place.latitude, longitude: place.longitudine)
                for event in events {
                    let eventCoordinates = CLLocation(latitude: event.coordinates[1], longitude: event.coordinates[0])
                    
                    // Distanza in km
                    let distance = placeCoordinates.distance(from: eventCoordinates) / 1000
                    
                    if distance <= place.distance && event.magnitudo >= place.magnitude {
                        let center = UNUserNotificationCenter.current()
                        
                        let content = UNMutableNotificationContent()
                        content.title = "Seismic event detected"
                        content.body = "Seismic event detected near \(place.name) with magnitude \(event.magnitudo)"
                        content.sound = UNNotificationSound.default
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                        
                        let notificationRequest: UNNotificationRequest = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
                        
                        center.add(notificationRequest, withCompletionHandler: { (error) in
                            if let error = error {
                                print(error)
                            }
                            else {
                                print("Notification added")
                            }
                        })
                    }
                }
            }
        }
    }
    
}