//
//Project name: together
//File name: UrlForRequestCell.swift
//
//Copyright © Gromov V.O., 2024
//


import Foundation
import UIKit

// MARK: - URL Cell

// cell can handle the input and then return the clear value to the ViewController via this ptotocol
protocol URLCellProtocol: AnyObject {
    func userEndEditing(url: String)
}

final class UrlForRequestCell: UITableViewCell {

    static let id = "UrlForRequestCell"
    static let nameForSection = "Server URL for request"
    weak var delegate: URLCellProtocol?
    
    private let placeholder = "https://www.google.com"
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.returnKeyType = .done
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // we can adjust the cell using this func
    func configure(with url: String) {
            textField.text = url
        }
    
    private func setupView() {
        self.selectionStyle = .none
        
        contentView.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

extension UrlForRequestCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.userEndEditing(url: textField.text ?? "error")
        return true
    }
}
