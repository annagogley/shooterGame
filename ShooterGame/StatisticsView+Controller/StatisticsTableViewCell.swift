//
//  StatTableViewCell.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {

    static let identifier = "StatCell"
    
    private let userScoreLabel: UILabel = {
        let label = UILabel()
        label.setupTableViewCellLabel(label: label, font: UIFont.systemFont(ofSize: 16))
        return label
    }()
    private let shotScoreLabel: UILabel = {
        let label = UILabel()
        label.setupTableViewCellLabel(label: label, font: UIFont.systemFont(ofSize: 16))
        return label
    }()
    private let accuracyLabel: UILabel = {
        let label = UILabel()
        label.setupTableViewCellLabel(label: label, font: UIFont.boldSystemFont(ofSize: 16))
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.setupTableViewCellLabel(label: label, font: UIFont.italicSystemFont(ofSize: 16))
        return label
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5.0
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSV()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSV() {
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(userScoreLabel)
        stackView.addArrangedSubview(shotScoreLabel)
        stackView.addArrangedSubview(accuracyLabel)
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
