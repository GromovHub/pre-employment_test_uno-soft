//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import Foundation
import CoreData


extension SpeedRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpeedRecord> {
        return NSFetchRequest<SpeedRecord>(entityName: "SpeedRecord")
    }

    @NSManaged public var downloadSpeed: Double
    @NSManaged public var requestedUrl: String?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var uploadSpeed: Double

}

extension SpeedRecord : Identifiable {

}
