//
//  CustomTableViewCell.swift
//  table
//
//  Created by Абай on 08.06.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    let disciplineNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let lessonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(disciplineNameLabel)
        addSubview(lessonStackView)
        
        NSLayoutConstraint.activate([
            disciplineNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            disciplineNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            disciplineNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            lessonStackView.topAnchor.constraint(equalTo: disciplineNameLabel.bottomAnchor, constant: 8),
            lessonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lessonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lessonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
