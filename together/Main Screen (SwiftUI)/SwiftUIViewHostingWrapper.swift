//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import Foundation
import UIKit
import SwiftUI

class SwiftUIViewHostingWrapper<T: View>: SettingsViewController {
    private let _swiftUIView: T
    
    init(view: T) {
        self._swiftUIView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostingVC = UIHostingController(rootView: _swiftUIView)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.view.frame = view.frame
        hostingVC.didMove(toParent: self)
        
    }
}
