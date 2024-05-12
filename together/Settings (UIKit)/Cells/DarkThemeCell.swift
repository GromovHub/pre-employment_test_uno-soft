//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import Foundation
import UIKit

// MARK: - Dark Theme Cell

// cell can handle the input and then return the clear value to the ViewController via this ptotocol
protocol DarkThemeCellProtocol: AnyObject {
    func darkThemeChanged(darkIsOn: Bool)
}

class DarkThemeCell: UITableViewCell {
    
    static let id = "DarkThemeCell"
    static let nameForSection = "Appearance"
    weak var delegate: DarkThemeCellProtocol?
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Dark theme"
        return label
    }()
    
    private lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(themeChanged(_:)), for: .valueChanged)
        return toggle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // we can adjust the cell using this func
    func configure(with state: Bool) {
        toggle.isOn = state
    }
    
    private func setupView() {
        
        self.selectionStyle = .none
        
        contentView.addSubview(label)
        contentView.addSubview(toggle)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        toggle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            toggle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            toggle.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            toggle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6)
        ])
    }
    
    @objc func themeChanged(_ sender: UISwitch) {
        delegate?.darkThemeChanged(darkIsOn: sender.isOn)
    }
}
