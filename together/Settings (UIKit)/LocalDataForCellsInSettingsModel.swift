//
//  LocalDataForCellsInSettingsModel.swift
//  together
//
//

import Foundation
import UIKit

// object collects data from all view to transfer
class LocalDataForCellsInSettingsModel {
    var url: String
    var uploadIsOn: Bool
    var darkThemeIsOn: Bool
    
    init(url: String, uploadIsOn: Bool, darkThemeIsOn: Bool) {
        self.url = url
        self.uploadIsOn = uploadIsOn
        self.darkThemeIsOn = darkThemeIsOn
    }
}
