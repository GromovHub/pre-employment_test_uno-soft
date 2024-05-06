//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import Foundation
import CoreData


extension AppSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppSettings> {
        return NSFetchRequest<AppSettings>(entityName: "AppSettings")
    }

    @NSManaged public var darkTheme: Bool
    @NSManaged public var measureUpload: Bool
    @NSManaged public var url: String?

}

extension AppSettings : Identifiable {

}
