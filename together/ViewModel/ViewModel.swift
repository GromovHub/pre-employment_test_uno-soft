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
    
    var views: [UIViewController] = []
    
    var coordinatorDelegate: ViewModelToCoordinatorProtocol?
    
    let coreDataService = CoreDataService()
    let measureSpeedDervice = MeasureSpeedService()
    
    @Published var appSettings: AppSettings
    
    @Published var items = [1,2,3]



    init() {
        self.appSettings = coreDataService.fetchSettings()
    }
    
    private func sendAppSettingsToViews() {
        // main screen
        
        // settings screen
        guard let settingsScreen = views[1] as? SettingsViewController else { return }
        settingsScreen.updateViews(appSettings: appSettings)
    }
    
    
    func addNewItem() {
        self.items.append(Int.random(in: 100...100000))
    }
}

extension ViewModel: SettingsToViewModelProtocol {
    
    func sendDataFromSettingsToViewModel(localSettings: LocalDataForCellsInSettingsModel) {
        // spdate Coredata settings Object
        appSettings.url = localSettings.url
        appSettings.measureUpload = localSettings.uploadIsOn
        appSettings.darkTheme = localSettings.darkThemeIsOn
        // and save context
        coreDataService.saveContext()
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


