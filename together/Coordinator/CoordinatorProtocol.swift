//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import Foundation
import UIKit

// MARK: - basic requirements for any coordinator

protocol CoordinatorProtocol {
    var rootNavigationController: UINavigationController { get set }
    func start()
}
