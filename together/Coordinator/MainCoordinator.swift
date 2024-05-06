//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import Foundation
import UIKit
import SwiftUI

class MainCoordinator {
    
    // MARK: - Init ViewModel
    private lazy var viewModel = ViewModel()
    
    // MARK: - Init Views
    private lazy var settingsVC = SettingsViewController()
    private lazy var mainScreenView = UIHostingController(rootView: MainView(VM: viewModel))
    
    // MARK: - Coordinator Properties
    var rootNavigationController: UINavigationController
    
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
        setupDependency()
    }
    
    // MARK: - Dependency
    private func setupDependency() {
        self.viewModel.views = [mainScreenView, settingsVC]
        self.viewModel.coordinatorDelegate = self
        self.settingsVC.viewModelDelegate = viewModel
    }
}


// MARK: - Coordiantor Init
extension MainCoordinator: CoordinatorProtocol {
    func start() {
        self.rootNavigationController.navigationBar.prefersLargeTitles = true
        self.rootNavigationController.pushViewController(mainScreenView, animated: true)
    }
}

// MARK: - Coordinator Logic
extension MainCoordinator: ViewModelToCoordinatorProtocol {
    func show(screen: CoordinatorEnum) {
        switch screen {
        case .mainScreen:
            self.rootNavigationController.popToRootViewController(animated: true)
        case .settingsScreen:
            self.rootNavigationController.pushViewController(settingsVC, animated: true)
        }
    }
}
