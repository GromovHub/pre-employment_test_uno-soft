//
//Project name: together
//File name: UploadSpeedCell.swift
//
//Copyright © Gromov V.O., 2024
//


import Foundation
import UIKit

// MARK: - Upload Speed Cell

// cell can handle the input and then return the clear value to the ViewController via this ptotocol
protocol UploadSpeedCellProtocol: AnyObject {
    func userСhangedMeasurements(uploadSpeed: Bool)
}

class UploadSpeedCell: UITableViewCell {
    
    static let id = "UploadSpeedCell"
    static let nameForSection = "Measurements"
    weak var delegate: UploadSpeedCellProtocol?
    
     private lazy var titleLabel: UILabel = {
         let label = UILabel()
         label.text = "Measure Upload Speed"
         return label
     }()
    
     private lazy var toggle: UISwitch = {
         let toggle = UISwitch()
         toggle.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
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
         contentView.addSubview(titleLabel)
         contentView.addSubview(toggle)
        
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         toggle.translatesAutoresizingMaskIntoConstraints = false
        
         NSLayoutConstraint.activate([
             titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
             toggle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
             toggle.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
             toggle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6)
         ])
     }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        delegate?.userСhangedMeasurements(uploadSpeed: sender.isOn)
    }
 }
