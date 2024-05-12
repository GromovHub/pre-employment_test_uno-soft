//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import Foundation
import SwiftUI
import UIKit


protocol SettingsToViewModelProtocol: AnyObject {
    func show(screen: CoordinatorEnum)
    func getDataFromViewModelToSettings()
    func sendDataFromSettingsToViewModel(localSettings: LocalDataForCellsInSettingsModel)
}

final class ViewModel: ObservableObject {
    
    // current ViewModel manages multiple views through this property
    var views: [UIViewController] = []
    
    // properties for speed measurement results
    @Published var downloadSpeed: String = "---"
    @Published var uploadSpeed: String = "---"
    
    // coordinator dependency
    var coordinatorDelegate: ViewModelToCoordinatorProtocol?
    
    // services
    private let coreDataService = CoreDataService()
    private let measureSpeedService = MeasureSpeedService()
    
    // persistent settings from CoreData
    @Published var appSettings: AppSettings
    
    init() {
        // update local data from persistent container
        self.appSettings = coreDataService.fetchSettings()
    }
    
    private func sendAppSettingsToViews() {
        // main screen
        // main screen handle settings with @Published var appSettings: AppSettings
        
        // settings screen
        guard let settingsScreen = views[1] as? SettingsViewController else { return }
        settingsScreen.updateViews(with: appSettings)
    }
}

// MARK: - Networking

extension ViewModel {
    func getDownloadSpeed() {
        self.downloadSpeed = "counting"
        measureSpeedService.measureDownloadSpeed(url: appSettings.url!) { [weak self] speed in
            guard let self = self else { print("no self"); return}
            // set a new value in the main serial queue
            DispatchQueue.main.async {
                self.downloadSpeed = speed
            }
        }
    }
    
    func getUploadSpeed() {
        self.uploadSpeed = "counting"
        measureSpeedService.measureUploadSpeed(url: appSettings.url!) { [weak self] speed in
            guard let self = self else { print("no self"); return}
            // set a new value in the main serial queue
            DispatchQueue.main.async {
                self.uploadSpeed = speed
            }
        }
    }
}

extension ViewModel: SettingsToViewModelProtocol {
    
    func sendDataFromSettingsToViewModel(localSettings: LocalDataForCellsInSettingsModel) {
        // update Coredata settings Object
        appSettings.url = localSettings.url
        appSettings.measureUpload = localSettings.uploadIsOn
        appSettings.darkTheme = localSettings.darkThemeIsOn
        // and save context
        coreDataService.saveContext()
        // also save to the user defaults
        UserDefaults.standard.set(appSettings.darkTheme, forKey: "initTheme")
        // and update local settings from persistent container
        self.appSettings = coreDataService.fetchSettings()
    }
    
    // view asks for data if ready or will be updated
    func getDataFromViewModelToSettings() {
        sendAppSettingsToViews()
    }
    
    // settings screen can show a different view if needed
    func show(screen: CoordinatorEnum) {
        coordinatorDelegate?.show(screen: .mainScreen)
    }
}


