//
//  StatTableViewCell.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import UIKit

class StatTableViewCell: UITableViewCell {

    static let identifier = "StatCell"
    
    private let userScoreLabel = UILabel()
    private let shotScoreLabel = UILabel()
    private let accuracyLabel = UILabel()
    private let dateLabel = UILabel()
    private let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSV()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel(label: UILabel, isItalic: Bool, isBold: Bool) {
        if isItalic {
            label.font = .italicSystemFont(ofSize: 16)
        } else if isBold {
            label.font = .boldSystemFont(ofSize: 16)
        } else {
            label.font = .systemFont(ofSize: 16)
        }
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupSV() {
        setupLabel(label: dateLabel, isItalic: true, isBold: false)
        setupLabel(label: userScoreLabel, isItalic: false, isBold: false)
        setupLabel(label: shotScoreLabel, isItalic: false, isBold: false)
        setupLabel(label: accuracyLabel, isItalic: false, isBold: true)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(userScoreLabel)
        stackView.addArrangedSubview(shotScoreLabel)
        stackView.addArrangedSubview(accuracyLabel)
        stackView.axis = .vertical
        stackView.spacing = 5.0
        stackView.alignment = .leading
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    public func configureCellWith(date: String, userScore: Double, shotScore: Double, accuracy: Double) {
        self.dateLabel.text = date
        self.userScoreLabel.text = "Number of your hits \(Int(userScore))"
        self.shotScoreLabel.text = "Number of your shots \(Int(shotScore))"
        self.accuracyLabel.text = "Your accuracy was \(NSString(format: "%.2f", accuracy * 100))%"
    }
}
