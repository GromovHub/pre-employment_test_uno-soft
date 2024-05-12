//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import Foundation
import UIKit
import SwiftUI
import CoreData

class CoreDataService {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    @Environment(\.managedObjectContext)
    
    func saveContext() {
        do {
            try context.save()
            print("Context are saved +")
        } catch {
            print("Context are not saved -")
        }
    }
    
    func fetchSettings() -> AppSettings {
        var result: [AppSettings] = []
        do {
            result = try context.fetch(AppSettings.fetchRequest())
            if result.isEmpty {
                let newSettings = AppSettings(context: self.context)
                newSettings.url = "https://www.google.com"
                newSettings.measureUpload = false
                newSettings.darkTheme = false
                result.append(newSettings)
            }
            print("settings fetched")
        } catch {
            print("settings retch error -")
        }
        return result[0]
    }
    
    func fetchSpeedRecords() -> [SpeedRecord] {
        var result: [SpeedRecord] = []
        do {
            print("speed records fetched")
            result = try context.fetch(SpeedRecord.fetchRequest())
        } catch {
            print("speed retch error -")
        }
        return result
    }
}
